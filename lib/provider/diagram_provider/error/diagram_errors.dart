import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_enums.dart';

class DiagramErrors<T extends ErrorType> {
  final Set<T> errors = {};

  bool isError(T error) {
    return errors.contains(error);
  }

  String getErrorMessage(T error) {
    return isError(error) ? error.message : '';
  }

  void addError(T error) {
    errors.add(error);
  }

  bool get hasError {
    return errors.isNotEmpty;
  }

  String get errorMessage {
    return errors.map((e) => e.message).join('\n');
  }
}

class StateErrors extends DiagramErrors<StateErrorType> {
  final String stateId;

  StateErrors({
    required this.stateId,
  });
}

class TransitionErrors extends DiagramErrors<TransitionErrorType> {
  final String transitionId;

  TransitionErrors({
    required this.transitionId,
  });
}

class SymbolErrors extends DiagramErrors<SymbolErrorType> {
  final String symbol;

  SymbolErrors({
    required this.symbol,
  });
}

class TransitionFunctionErrors
    extends DiagramErrors<TransitionFunctionErrorType> {
  final String stateId;
  final String symbol;

  TransitionFunctionErrors({
    required this.stateId,
    required this.symbol,
  });
}

class TransitionFunctionEntryErrors
    extends DiagramErrors<TransitionFunctionEntryErrorType> {
  final String stateId;
  final String symbol;

  TransitionFunctionEntryErrors({
    required this.stateId,
    required this.symbol,
  });
}
