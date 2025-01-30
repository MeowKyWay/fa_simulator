import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';

class ToggleFocusAction extends AppUnrevertableAction {
  final List<String> ids;

  ToggleFocusAction(
    this.ids,
  );

  @override
  Future<void> execute() async {
    FocusProvider().toggleFocusAll(ids);
  }
}
