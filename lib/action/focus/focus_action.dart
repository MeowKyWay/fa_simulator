import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';

class FocusAction extends AppUnrevertableAction {
  final List<String> ids;

  FocusAction(
    this.ids,
  );

  @override
  Future<void> execute() async {
    FocusProvider().requestFocusAll(ids);
  }
}
