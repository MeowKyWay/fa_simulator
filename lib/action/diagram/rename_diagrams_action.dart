import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';

class RenameDiagramsAction extends AppAction {
  final String id;
  final String name;
  late String? oldName;

  RenameDiagramsAction({
    required this.id,
    required this.name,
    this.oldName,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    String old = DiagramList().item(id).label;
    DiagramList().executeCommand(
      UpdateItemCommand(detail: ItemDetail(id: id, label: name)),
    );
    oldName ??= old;
    RenamingProvider().reset();
  }

  @override
  Future<void> undo() async {
    DiagramList().executeCommand(
      UpdateItemCommand(detail: ItemDetail(id: id, label: oldName!)),
    );
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
