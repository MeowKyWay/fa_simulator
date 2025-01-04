import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';

class AddFocusAction extends AppUnrevertableAction {
  final List<String> ids;

  AddFocusAction(
    this.ids,
  );

  @override
  Future<void> execute() async {
    addFocus(ids);
  }
}
