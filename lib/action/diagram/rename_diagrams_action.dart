import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
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
  void execute() {
    String old = DiagramList().renameItem(id, name);
    oldName ??= old;
    RenamingProvider().reset();
  }

  @override
  void undo() {
    DiagramList().renameItem(id, oldName!);
  }

  @override
  void redo() {
    execute();
  }
}