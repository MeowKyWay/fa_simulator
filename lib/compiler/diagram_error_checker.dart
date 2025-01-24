import 'package:fa_simulator/compiler/diagram_error_list.dart';
import 'package:fa_simulator/compiler/error/diagram_error.dart';
import 'package:fa_simulator/compiler/error/state_error.dart';
import 'package:fa_simulator/compiler/error/symbol_error.dart';
import 'package:fa_simulator/compiler/error/transition_error.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list_alphabet.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';

extension DiagramErrorChecker on DiagramErrorList {
  void addError(DiagramErrors error) {
    errors.add(error);
  }

  void checkError() {
    List<StateType> states = DiagramList().states;
    List<TransitionType> transitions = DiagramList().transitions;
    List<String> alphabet = DiagramList().symbols.toList();

    _checkStatesError(states);
    _checkTransitionsError(transitions);
    _checkAlphabetError(alphabet);
  }

  void _checkStatesError(List<StateType> states) {
    Set<String> stateNames = {};
    bool initialFlag = false;
    bool finalFlag = false;
    // Check every state
    for (int i = 0; i < states.length; i++) {
      StateType state = states[i];
      StateErrors stateErrors = StateErrors(
        errors: [],
        stateId: state.id,
      );

      if (state.label.isEmpty) {
        // If state label is empty, add unnamed state error
        stateErrors.addError(StateErrorType.unnamedState);
      } else if (stateNames.contains(state.label)) {
        // If state label is duplicate, add duplicate state name error
        stateErrors.addError(StateErrorType.duplicateStateName);
      }
      stateNames.add(state.label); // Add state label to stateNames
      if (state.isInitial) {
        // If state is initial and there is already an initial state, add duplicate initial state error
        if (initialFlag) {
          stateErrors.addError(StateErrorType.duplicateInitialState);
        }
        initialFlag = true;
      }
      if (state.isFinal) {
        finalFlag = true;
      }
      if (i == states.length - 1) {
        // If there is no final state, add no final state error
        if (!finalFlag) stateErrors.addError(StateErrorType.noFinalState);
        if (!initialFlag) stateErrors.addError(StateErrorType.noInitialState);
      }
      if (stateErrors.hasError) {
        addError(stateErrors);
      }
    }
  }

  void _checkTransitionsError(List<TransitionType> transitions) {
    for (int i = 0; i < transitions.length; i++) {
      TransitionType transition = transitions[i];
      TransitionErrors transitionErrors = TransitionErrors(
        errors: [],
        transitionId: transition.id,
      );

      if (transition.sourceStateId == null ||
          transition.destinationStateId == null) {
        transitionErrors.addError(TransitionErrorType.inCompleteTransition);
      }
      if (transition.symbols.isEmpty) {
        transitionErrors.addError(TransitionErrorType.emptyTransition);
      }
      if (transitionErrors.hasError) {
        addError(transitionErrors);
      }
    }
  }

  void _checkAlphabetError(List<String> alphabet) {
    List<String> unregisteredAlphabet;
    unregisteredAlphabet = DiagramList().unregisteredAlphabet.toList();

    for (int i = 0; i < alphabet.length; i++) {
      String symbol = alphabet[i];
      SymbolErrors alphabetErrors = SymbolErrors(
        errors: [],
        symbol: symbol,
      );

      if (unregisteredAlphabet.contains(symbol)) {
        alphabetErrors.addError(SymbolErrorType.unregisteredSymbol);
      }
      if (alphabetErrors.hasError) {
        addError(alphabetErrors);
      }
    }
  }
}
