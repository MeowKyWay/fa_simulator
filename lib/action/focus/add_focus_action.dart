import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';

class AddFocusAction extends AppUnrevertableAction {
  final List<String> ids;

  AddFocusAction(
    this.ids,
  );

  @override
  void execute() {
    for (String id in ids) {
      StateList().addFocus(id);
    }
  }
}
