import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

enum StateErrorType {
  unnamedState,
  duplicateStateName,
  duplicateInitialState,
  noFinalState,
}

class StateCompiler {
  static Map<String, List<StateErrorType>> compile(List<StateType> states) {
    final Map<String, List<StateErrorType>> errors = {};

    final Set<String> stateNames = {};
    bool initialFlag = false;
    bool finalFlag = false;

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
      if (state.isFinal) {
        finalFlag = true;
      }
      if (errors[state.id]!.isEmpty) {
        errors.remove(state.id);
      }
    }
    if (!finalFlag) {
      if (errors[states.last.id] == null) {
        errors[states.last.id] = [];
      }
      errors[states.last.id]!.add(StateErrorType.noFinalState);
    }

    return errors;
  }
}
