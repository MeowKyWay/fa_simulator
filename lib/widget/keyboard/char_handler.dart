import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';

void handleChar(String? char) {
  if (char == null) {
    return;
  }
  if (DiagramList().renamingItemId.isNotEmpty) {
    return;
  }
  //TODO handle transition
  List<StateType> focusedStates = DiagramList().focusedStates;
  if (focusedStates.length == 1) {
    DiagramList().startRename(focusedStates[0].id, initialName: char);
  }
}
