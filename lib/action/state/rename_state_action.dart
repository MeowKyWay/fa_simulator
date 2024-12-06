import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';

class RenameStateAction implements AppAction {
  final String stateId;
  final String name;
  late String? oldName;

  RenameStateAction({
    required this.stateId,
    required this.name,
    this.oldName,
  });

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    String old = renameState(stateId, name);
    oldName ??= old;
    DiagramList().endRename();
  }

  @override
  void undo() {
    renameState(stateId, oldName!);
  }

  @override
  void redo() {
    execute();
  }
}
