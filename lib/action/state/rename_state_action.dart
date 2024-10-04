import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';

class RenameStateAction implements AppAction {
  final String id;
  final String name;
  late String oldName;

  RenameStateAction(
    this.id,
    this.name,
  );

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    oldName = renameState(id, name);
    DiagramList().endRename();
  }

  @override
  void undo() {
    renameState(id, oldName);
  }

  @override
  void redo() {
    execute();
  }
}
