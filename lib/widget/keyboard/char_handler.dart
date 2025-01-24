import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';

void handleChar(String? char) {
  if (char == null) {
    return;
  }
  if (RenamingProvider().renamingItemId != null) {
    return;
  }
  List<DiagramType> focusedItems = DiagramList().focusedItems;
  if (focusedItems.length == 1) {
    RenamingProvider().startRename(
      id: focusedItems[0].id,
      initialName: char,
    );
  }
}
