import 'package:fa_simulator/compiler/error/diagram_error.dart';

enum TransitionErrorType {
  emptyTransition,
  inCompleteTransition,
}

extension TransitionErrorTypeExtension on TransitionErrorType {
  String get message {
    switch (this) {
      case TransitionErrorType.emptyTransition:
        return 'Transition must include at least one symbol.';
      case TransitionErrorType.inCompleteTransition:
        return 'Transition must have both a source and a destination state.';
    }
  }
}

class TransitionErrors extends DiagramErrors<TransitionErrorType> {
  final String transitionId;

  // If there is an error specified, return the error type
  TransitionErrorType? get isEmpty =>
      isError(TransitionErrorType.emptyTransition);
  TransitionErrorType? get isInComplete =>
      isError(TransitionErrorType.inCompleteTransition);

  TransitionErrors({
    required super.errors,
    required this.transitionId,
  });
}
