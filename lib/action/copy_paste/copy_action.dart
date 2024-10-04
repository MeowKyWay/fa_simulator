import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/action/diagram_clipboard.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';

class CopyAction implements AppAction {
  @override
  bool isRevertable = false;

  @override
  void execute() {
    DiagramClipboard().copy(DiagramList().focusedItems);
  }

  @override
  void undo() {

  }

  @override
  void redo() {

  }
}