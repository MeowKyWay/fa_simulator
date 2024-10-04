import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';

class FocusAction extends AppUnrevertableAction {
  final List<String> ids;

  FocusAction(
    this.ids,
  );

  @override
  void execute() {
    requestFocus(ids);
  }
}
