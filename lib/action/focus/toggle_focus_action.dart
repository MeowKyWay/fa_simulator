import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';

class ToggleFocusAction extends AppUnrevertableAction {
  final String id;

  ToggleFocusAction(
    this.id,
  );

  @override
  void execute() {
    StateList().toggleFocus(id);
  }
}