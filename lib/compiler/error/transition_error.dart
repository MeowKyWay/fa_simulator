import 'package:fa_simulator/compiler/error/diagram_error.dart';

enum TransitionErrorType {
  emptyTransition,
  undefinedSource,
  undefinedDestination,
}

extension TransitionErrorTypeExtension on TransitionErrorType {
  String get message {
    switch (this) {
      case TransitionErrorType.emptyTransition:
        return 'Transition must include at least one symbol.';
      case TransitionErrorType.undefinedSource:
        return 'Transition must have a source state.';
      case TransitionErrorType.undefinedDestination:
        return 'Transition must have a destination state.';
    }
  }
}

class TransitionErrors extends DiagramErrors<TransitionErrorType> {
  final String transitionId;

  // If there is an error specified, return the error type
  TransitionErrorType? get isEmpty =>
      isError(TransitionErrorType.emptyTransition);
  TransitionErrorType? get isUndefinedSource =>
      isError(TransitionErrorType.undefinedSource);
  TransitionErrorType? get isUndefinedDestination =>
      isError(TransitionErrorType.undefinedDestination);

  TransitionErrors({
    required super.errors,
    required this.transitionId,
  });
}
