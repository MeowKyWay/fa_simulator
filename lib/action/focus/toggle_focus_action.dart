import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';

class ToggleFocusAction extends AppUnrevertableAction {
  final List<String> ids;

  ToggleFocusAction(
    this.ids,
  );

  @override
  Future<void> execute() async {
    toggleFocus(ids);
  }
}