import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';

class UnfocusAction extends AppUnrevertableAction {
  @override
  void execute() {
    StateList().unfocus();
  }
}