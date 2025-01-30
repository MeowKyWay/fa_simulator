import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';

class AddFocusAction extends AppUnrevertableAction {
  final List<String> ids;

  AddFocusAction(
    this.ids,
  );

  @override
  Future<void> execute() async {
    FocusProvider().addFocusAll(ids);
  }
}
