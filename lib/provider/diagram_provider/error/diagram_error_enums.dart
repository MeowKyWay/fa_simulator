import 'package:tuple/tuple.dart';

abstract interface class ErrorType<T> {
  String get message => '';

  String detail(T item);
}

enum DiagramErrorType implements ErrorType<Null> {
  noType,
  noInitialState,
  duplicateInitialState;

  @override
  String get message {
    switch (this) {
      case DiagramErrorType.noType:
        return 'The type of the diagram must be specified.';
      case DiagramErrorType.noInitialState:
        return 'There must be at least one initial state.';
      case DiagramErrorType.duplicateInitialState:
        return 'There can only be one initial state.';
    }
  }

  @override
  String detail(Null item) {
    switch (this) {
      case DiagramErrorType.noType:
        return 'The type of the diagram is not specified.\nTry specifying the type of the diagram.';
      case DiagramErrorType.noInitialState:
        return 'There is no initial state in the diagram.\nTry adding an initial state to the diagram.';
      case DiagramErrorType.duplicateInitialState:
        return 'There are multiple initial states in the diagram.\nTry removing the extra initial states.';
    }
  }
}

enum StateErrorType implements ErrorType<String> {
  unnamedState,
  duplicateStateName;

  @override
  String get message {
    switch (this) {
      case StateErrorType.unnamedState:
        return 'State must have a name.';
      case StateErrorType.duplicateStateName:
        return 'State name must be unique.';
    }
  }

  @override
  String detail(String item) {
    switch (this) {
      case StateErrorType.unnamedState:
        return 'The state \'$item\' does not have a name.\nTry naming the state.';
      case StateErrorType.duplicateStateName:
        return 'The state \'$item\' has a duplicate name with another state.\nTry renaming the state to a unique name.';
    }
  }
}

enum TransitionErrorType implements ErrorType<String> {
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

  @override
  String detail(String item) {
    switch (this) {
      case TransitionErrorType.emptyTransition:
        return 'The transition \'$item\' does not have any symbols.\nTry adding symbols to the transition.';
      case TransitionErrorType.undefinedSource:
        return 'The transition \'$item\' does not have a source state.\nTry attaching a source state to the transition.';
      case TransitionErrorType.undefinedDestination:
        return 'The transition \'$item\' does not have a destination state.\nTry attaching a destination state to the transition.';
    }
  }
}

enum SymbolErrorType implements ErrorType<String> {
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

  @override
  String detail(String item) {
    switch (this) {
      case SymbolErrorType.unregisteredSymbol:
        return 'The symbol \'$item\' is not part of the alphabet.\nTry adding it to the alphabet or removing it from the diagram.';
      case SymbolErrorType.illegalSymbol:
        return 'The symbol \'$item\' is not permitted in this diagram.\nTry using a different symbol.';
    }
  }
}

enum TransitionFunctionErrorType implements ErrorType<Tuple2<String, String>> {
  noTransitionFunction;

  @override
  String get message {
    switch (this) {
      case TransitionFunctionErrorType.noTransitionFunction:
        return 'There must be a transition for each symbol for each state.';
    }
  }

  @override
  String detail(Tuple2<String, String> item) {
    switch (this) {
      case TransitionFunctionErrorType.noTransitionFunction:
        return 'The state \'${item.item1}\' does not have a transition for the symbol \'${item.item2}\'.\nTry adding a transition for this symbol.';
    }
  }
}

enum TransitionFunctionEntryErrorType
    implements ErrorType<Tuple2<String, String>> {
  multipleDestinationStates; //Only DFA

  @override
  String get message {
    switch (this) {
      case TransitionFunctionEntryErrorType.multipleDestinationStates:
        return 'A state in a DFA must have only one destination state for each symbol.';
    }
  }

  @override
  String detail(Tuple2<String, String> item) {
    switch (this) {
      case TransitionFunctionEntryErrorType.multipleDestinationStates:
        return 'The state \'${item.item1}\' has multiple destination states for the symbol \'${item.item2}\'.\nTry removing the extra destination states.';
    }
  }
}
