import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/focus_provider.dart';

class FocusAllAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    Set<String> ids = DiagramList().items.map((e) => e.id).toSet();
    FocusProvider().requestFocusAll(ids);
  }
}
