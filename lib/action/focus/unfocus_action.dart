import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';

class UnfocusAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    FocusProvider().unfocus();
  }
}
