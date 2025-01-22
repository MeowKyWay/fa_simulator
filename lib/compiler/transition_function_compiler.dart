import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';

enum TransitionFunctionErrorType {
  unnamedSourceState,
  unnamedDestinationState,

  unregisteredAlphabet,

  multipleDestinationStates,

  missingTransition,
}

class TransitionFunctionCompiler {
  static Map<TransitionFunctionKey, List<TransitionFunctionErrorType>> compile(
    TransitionFunctionType transitionFunction,
  ) {
    final Map<TransitionFunctionKey, List<TransitionFunctionErrorType>> errors =
        {};

    for (final entry in transitionFunction.entries) {
      final key = entry.key;
      final value = entry.value;

      errors[key] = [];

      // If source state label is empty, add unnamed source state error
      if (key.sourceStateLabel.isEmpty) {
        errors[key]!.add(TransitionFunctionErrorType.unnamedSourceState);
      }

      // If symbol is not registered in the alphabet, add unregistered alphabet error
      if (!DiagramList().alphabet.contains(key.symbol)) {
        errors[key]!.add(TransitionFunctionErrorType.unregisteredAlphabet);
      }

      // dfa specific checks
      // If there are multiple destination states, add multiple destination states error
      if (FileProvider().faType == FAType.dfa) {
        if (value.destinationStateLabels.length > 1) {
          errors[key]!
              .add(TransitionFunctionErrorType.multipleDestinationStates);
        }
      }

      // If any destination state label is empty, add unnamed destination state error
      if (value.destinationStateLabels.any((e) => e.isEmpty)) {
        errors[key]!.add(TransitionFunctionErrorType.unnamedDestinationState);
      }
    }

    // dfa specific checks
    // If there are missing transitions, add missing transition error
    if (FileProvider().faType == FAType.dfa) {
      errors.addAll(_checkMissingTransitions(transitionFunction));
    }

    return errors;
  }

  static Map<TransitionFunctionKey, List<TransitionFunctionErrorType>>
      _checkMissingTransitions(TransitionFunctionType transitionFunction) {
    final Map<TransitionFunctionKey, List<TransitionFunctionErrorType>> errors =
        {};

    final Set<String> alphabet = DiagramList().alphabet;

    for (final state in DiagramList().states) {
      for (final symbol in alphabet) {
        final key = TransitionFunctionKey(
          sourceStateId: state.id,
          symbol: symbol,
        );

        if (!transitionFunction.containsKey(key)) {
          errors[key] = [TransitionFunctionErrorType.missingTransition];
        }
      }
    }

    return errors;
  }
}
