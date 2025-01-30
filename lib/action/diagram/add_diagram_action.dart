import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';

class AddDiagramAction extends AppAction {
  final DiagramType item;

  AddDiagramAction({
    required this.item,
  });

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    DiagramList().executeCommand(
      AddItemCommand(item: item),
    );
    FocusProvider().requestFocus(item.id);
  }

  @override
  Future<void> undo() async {
    DiagramList().executeCommand(
      DeleteItemCommand(id: item.id),
    );
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
