import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';

void handleChar(String? char) {
  if (char == null) {
    return;
  }
  if (StateList().renamingStateId.isNotEmpty) {
    return;
  }
  //TODO handle transition
  List<StateType> focusedStates = StateList().focusedStates;
  if (focusedStates.length == 1) {
    StateList().startRename(focusedStates[0].id, initialName: char);
  }
}
