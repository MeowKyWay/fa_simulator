import 'package:fa_simulator/compiler/error/diagram_error.dart';

enum TransitionFunctionEntryErrorType {
  multipleDestinationStates, //Only DFA
  missingTransition, //Only NFA
}

extension TransitionErrorTypeExtension on TransitionFunctionEntryErrorType {
  String get message {
    switch (this) {
      case TransitionFunctionEntryErrorType.multipleDestinationStates:
        return 'A state in a DFA must have only one destination state for each symbol.';
      case TransitionFunctionEntryErrorType.missingTransition:
        return 'A state in a DFA must have an outgoing transition for every symbol.';
    }
  }
}

class TransitionFunctionEntryErrors
    extends DiagramErrors<TransitionFunctionEntryErrorType> {
  final String stateId;
  final String symbol;

  // If there is an error specified, return the error type
  TransitionFunctionEntryErrorType? get isMultipleDestination =>
      isError(TransitionFunctionEntryErrorType.multipleDestinationStates);
  TransitionFunctionEntryErrorType? get isMissing =>
      isError(TransitionFunctionEntryErrorType.missingTransition);

  TransitionFunctionEntryErrors({
    required super.errors,
    required this.stateId,
    required this.symbol,
  });
}
