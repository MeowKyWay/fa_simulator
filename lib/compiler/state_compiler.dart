import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

enum StateErrorType {
  unnamedState,
  duplicateStateName,
  duplicateInitialState,
}

class StateCompiler {
  static Map<String, List<StateErrorType>> compile(List<StateType> states) {
    final Map<String, List<StateErrorType>> errors = {};

    final Set<String> stateNames = {};
    bool initialFlag = false;

    for (final state in states) {
      errors[state.id] = [];
      // If state label is empty, add unnamed state error
      if (state.label.isEmpty) {
        errors[state.id]!.add(StateErrorType.unnamedState);
      }
      // If state label is duplicate, add duplicate state name error
      if (stateNames.contains(state.label)) {
        errors[state.id]!.add(StateErrorType.duplicateStateName);
      } else {
        stateNames.add(state.label);
      }
      // If state is initial and there is already an initial state, add duplicate initial state error
      if (state.isInitial) {
        if (initialFlag) {
          errors[state.id]!.add(StateErrorType.duplicateInitialState);
        } else {
          initialFlag = true;
        }
      }
    }

    return errors;
  }
}
