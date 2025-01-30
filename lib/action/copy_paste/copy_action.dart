import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/action/diagram_clipboard.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';

class CopyAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    Set<String> focusedItemsId = FocusProvider().focusedItemIds;
    List<DiagramType> focusedItems =
        DiagramList().getItemsByIds(focusedItemsId);
    DiagramClipboard.copy(focusedItems);
  }
}
