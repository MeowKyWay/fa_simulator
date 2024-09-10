import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';

class FocusAction extends AppUnrevertableAction {
  final List<String> ids;

  FocusAction(
    this.ids,
  );

  @override
  void execute() {
    StateList().requestGroupFocus(ids);
  }
}
