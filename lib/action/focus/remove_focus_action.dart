import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';

class RemoveFocusAction extends AppUnrevertableAction {
  final List<String> ids;

  RemoveFocusAction(
    this.ids,
  );

  @override
  Future<void> execute() async {
    FocusProvider().removeFocusAll(ids);
  }
}
