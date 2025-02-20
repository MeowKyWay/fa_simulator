import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_enums.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_errors.dart';
import 'package:fa_simulator/resource/diagram_constants.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_symbol.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:tuple/tuple.dart';

class DiagramValidator {
  DiagramErrorList? _errors;

  DiagramErrorList get errors {
    if (_errors == null) {
      validate();
    }
    return _errors!;
  }

  DiagramValidator();

  void validate() {
    _errors = DiagramErrorList();
    List<StateType> states = DiagramList().states;
    List<TransitionType> transitions = DiagramList().transitions;
    List<String> alphabet = DiagramList().allSymbol;
    TransitionFunctionType transitionFunction =
        DiagramList().compiler.transitionFunction;

    _checkStatesError(states);
    _checkTransitionsError(transitions);
    _checkAlphabetError(alphabet);
    _checkTransitionFunctionError(transitionFunction);
    _checkTransitionFunctionEntryError(transitionFunction);
  }

  void _checkStatesError(List<StateType> states) {
    Set<String> stateNames = {};
    int initialCount = 0;
    // Check every state
    for (int i = 0; i < states.length; i++) {
      StateType state = states[i];
      StateErrors stateErrors = StateErrors(
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
        initialCount++;
      }
      if (stateErrors.hasError) {
        errors[DiagramErrorClassType.stateError][state.id] = stateErrors;
      }
    }
    if (initialCount == 0) {
      errors[DiagramErrorClassType.diagramError].addError(
        DiagramErrorType.noInitialState,
      );
    }
    if (initialCount > 1) {
      errors[DiagramErrorClassType.diagramError].addError(
        DiagramErrorType.duplicateInitialState,
      );
    }
  }

  void _checkTransitionsError(List<TransitionType> transitions) {
    for (int i = 0; i < transitions.length; i++) {
      TransitionType transition = transitions[i];
      TransitionErrors transitionErrors = TransitionErrors(
        transitionId: transition.id,
      );

      if (transition.sourceStateId == null) {
        transitionErrors.addError(TransitionErrorType.undefinedSource);
      }
      if (transition.destinationStateId == null) {
        transitionErrors.addError(TransitionErrorType.undefinedDestination);
      }
      if (transition.symbols.isEmpty) {
        transitionErrors.addError(TransitionErrorType.emptyTransition);
      }
      if (transitionErrors.hasError) {
        errors[DiagramErrorClassType.transitionError][transition.id] =
            transitionErrors;
      }
    }
  }

  void _checkAlphabetError(List<String> alphabet) {
    List<String> unregisteredSymbols;
    unregisteredSymbols = DiagramList().unregisteredSymbols;

    for (int i = 0; i < alphabet.length; i++) {
      String symbol = alphabet[i];
      SymbolErrors alphabetErrors = SymbolErrors(
        symbol: symbol,
      );

      if (DiagramList().type == AutomataType.dfa) {
        if (symbol == DiagramCharacter.epsilon) {
          alphabetErrors.addError(SymbolErrorType.illegalSymbol);
        }
      }
      if (unregisteredSymbols.contains(symbol)) {
        alphabetErrors.addError(SymbolErrorType.unregisteredSymbol);
      }
      if (alphabetErrors.hasError) {
        errors[DiagramErrorClassType.symbolError][symbol] = alphabetErrors;
      }
    }
  }

  void _checkTransitionFunctionError(
    TransitionFunctionType transitionFunction,
  ) {
    if (DiagramList().type != AutomataType.dfa) return;

    List<String> alphabet = DiagramList().alphabet;

    for (StateType state in DiagramList().states) {
      for (String symbol in alphabet) {
        if (!transitionFunction.containEntry(state.id, symbol)) {
          TransitionFunctionErrors transitionFunctionErrors;
          transitionFunctionErrors = TransitionFunctionErrors(
            stateId: state.id,
            symbol: symbol,
          );
          transitionFunctionErrors.addError(
            TransitionFunctionErrorType.noTransitionFunction,
          );
          errors[DiagramErrorClassType.transitionFunctionError]
              [Tuple2(state.id, symbol)] = transitionFunctionErrors;
        }
      }
    }
  }

  void _checkTransitionFunctionEntryError(
      TransitionFunctionType transitionFunction) {
    final List<TransitionFunctionEntry> entries;
    entries = transitionFunction.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      TransitionFunctionEntry entry = entries[i];
      TransitionFunctionEntryErrors entryErrors = TransitionFunctionEntryErrors(
        stateId: entry.sourceStateId,
        symbol: entry.symbol,
      );

      if (entry.destinationStateIds.length > 1) {
        if (DiagramList().type == AutomataType.dfa) {
          entryErrors.addError(
            TransitionFunctionEntryErrorType.multipleDestinationStates,
          );
        }
      }
      if (entryErrors.hasError) {
        errors[DiagramErrorClassType.transitionFunctionEntryError]
            [Tuple2(entry.sourceStateId, entry.symbol)] = entryErrors;
      }
    }
  }
}
