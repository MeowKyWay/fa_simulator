abstract interface class ErrorType {
  String get message => '';
}

enum DiagramErrorType implements ErrorType {
  noType,
  noInitialState,
  noFinalState;

  @override
  String get message {
    switch (this) {
      case DiagramErrorType.noType:
        return 'The type of the diagram must be specified.';
      case DiagramErrorType.noInitialState:
        return 'There must be at least one initial state.';
      case DiagramErrorType.noFinalState:
        return 'There must be at least one final state.';
    }
  }
}

enum StateErrorType implements ErrorType {
  unnamedState,
  duplicateStateName,
  duplicateInitialState;

  @override
  String get message {
    switch (this) {
      case StateErrorType.unnamedState:
        return 'State must have a name.';
      case StateErrorType.duplicateStateName:
        return 'State name must be unique.';
      case StateErrorType.duplicateInitialState:
        return 'There can only be one initial state.';
    }
  }
}

enum TransitionErrorType implements ErrorType {
  emptyTransition,
  undefinedSource,
  undefinedDestination;

  @override
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

enum SymbolErrorType implements ErrorType {
  unregisteredSymbol,
  illegalSymbol;

  @override
  String get message {
    switch (this) {
      case SymbolErrorType.unregisteredSymbol:
        return 'The symbol is not part of the alphabet.';
      case SymbolErrorType.illegalSymbol:
        return 'The symbol is not permitted in this diagram.';
    }
  }
}

enum TransitionFunctionErrorType implements ErrorType {
  noTransitionFunction;

  @override
  String get message {
    switch (this) {
      case TransitionFunctionErrorType.noTransitionFunction:
        return 'There must be a transition for each symbol for each state.';
    }
  }
}

enum TransitionFunctionEntryErrorType implements ErrorType {
  multipleDestinationStates; //Only DFA

  @override
  String get message {
    switch (this) {
      case TransitionFunctionEntryErrorType.multipleDestinationStates:
        return 'A state in a DFA must have only one destination state for each symbol.';
    }
  }
}
