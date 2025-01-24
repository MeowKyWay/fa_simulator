import 'package:fa_simulator/compiler/error/diagram_error.dart';

enum StateErrorType {
  unnamedState,
  duplicateStateName,
  duplicateInitialState,
  noFinalState,
  noInitialState,
}

extension StateErrorTypeExtension on StateErrorType {
  String get message {
    switch (this) {
      case StateErrorType.unnamedState:
        return 'State must have a name.';
      case StateErrorType.duplicateStateName:
        return 'State name must be unique.';
      case StateErrorType.duplicateInitialState:
        return 'There can only be one initial state.';
      case StateErrorType.noFinalState:
        return 'There must be at least one final state.';
      case StateErrorType.noInitialState:
        return 'There must be at least one initial state.';
    }
  }
}

class StateErrors extends DiagramErrors<StateErrorType> {
  final String stateId;

  // If there is an error specified, return the error type
  StateErrorType? get isUnnamed => isError(StateErrorType.unnamedState);
  StateErrorType? get isDuplicateName =>
      isError(StateErrorType.duplicateStateName);
  StateErrorType? get isDuplicateInitial =>
      isError(StateErrorType.duplicateInitialState);
  StateErrorType? get isNoFinal => isError(StateErrorType.noFinalState);
  StateErrorType? get isNoInitial => isError(StateErrorType.noInitialState);

  StateErrors({
    required super.errors,
    required this.stateId,
  });
}
