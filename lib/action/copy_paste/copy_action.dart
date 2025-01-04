import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/action/diagram_clipboard.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';

class CopyAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    DiagramClipboard().copy(DiagramList().focusedItems);
  }
}