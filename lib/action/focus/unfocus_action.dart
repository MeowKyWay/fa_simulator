import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';

class UnfocusAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    unfocus();
  }
}