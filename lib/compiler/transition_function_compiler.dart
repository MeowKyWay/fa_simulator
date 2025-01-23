import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';

enum TransitionFunctionErrorType {
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

      // dfa specific checks
      // If there are multiple destination states, add multiple destination states error
      if (FileProvider().faType == FAType.dfa) {
        if (value.destinationStateLabels.length > 1) {
          errors[key]!
              .add(TransitionFunctionErrorType.multipleDestinationStates);
        }
      }
      if (errors[key]!.isEmpty) {
        errors.remove(key);
      }
    }

    // dfa specific checks
    // If there are missing transitions, add missing transition error
    if (FileProvider().faType == FAType.dfa) {
      final Set<String> alphabet = DiagramList().alphabet;

      for (final state in DiagramList().states) {
        for (final symbol in alphabet) {
          final key = TransitionFunctionKey(
            sourceStateId: state.id,
            symbol: symbol,
          );

          if (!transitionFunction.containsKey(key)) {
            if (errors[key] == null) {
              errors[key] = [];
            }
            errors[key]!.add(TransitionFunctionErrorType.missingTransition);
          }
        }
      }
    }

    return errors;
  }
}
