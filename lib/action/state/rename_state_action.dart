import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';

class RenameStateAction implements AppAction {
  final String id;
  final String name;
  late String oldName;

  RenameStateAction(
    this.id,
    this.name,
  );

  @override
  bool get isUndoable => true;

  @override
  void execute() {
    oldName = StateList().renameState(id, name);
    StateList().endRename();
  }

  @override
  void undo() {
    StateList().renameState(id, oldName);
  }

  @override
  void redo() {
    execute();
  }
}
