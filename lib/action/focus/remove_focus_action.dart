import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';

class RemoveFocusAction extends AppUnrevertableAction {
  final List<String> ids;

  RemoveFocusAction(
    this.ids,
  );

  @override
  void execute() {
    removeFocus(ids);
  }
}
