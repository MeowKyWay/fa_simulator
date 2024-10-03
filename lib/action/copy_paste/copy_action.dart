import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/action/diagram_clipboard.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';

class CopyAction implements AppAction {
  @override
  bool isRevertable = false;

  @override
  void execute() {
    DiagramClipboard().copy(StateList().focusedItems);
  }

  @override
  void undo() {

  }

  @override
  void redo() {

  }
}