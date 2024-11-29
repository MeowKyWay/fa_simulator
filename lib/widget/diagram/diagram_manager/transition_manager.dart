import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:uuid/uuid.dart';

TransitionType addTransition(
  StateType sourceState,
  StateType destinationState,
  String label,
  bool sourceStateCentered,
  bool destinationStateCentered,
  double soruceStateAngle,
  double destinationStateAngle, [
  String? id,
]) {
  TransitionType transition = TransitionType(
    id: id ?? const Uuid().v4(),
    label: label,
    sourceState: sourceState,
    destinationState: destinationState,
    sourceStateCentered: sourceStateCentered,
    destinationStateCentered: destinationStateCentered,
    sourceStateAngle: soruceStateAngle,
    destinationStateAngle: destinationStateAngle,
  );
  // Add the transition to the list
  DiagramList().resetRename();
  DiagramList().items.add(transition);
  DiagramList().notify();
  // Return the transition
  return transition;
}
