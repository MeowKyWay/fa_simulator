import 'package:fa_simulator/compiler/error/diagram_error.dart';

enum SymbolErrorType {
  unregisteredSymbol,
  illegalSymbol,
}

extension SymbolErrorTypeExtension on SymbolErrorType {
  String get message {
    switch (this) {
      case SymbolErrorType.unregisteredSymbol:
        return 'The symbol is not part of the alphabet.';
      case SymbolErrorType.illegalSymbol:
        return 'The symbol is not permitted in this diagram.';
    }
  }
}

class SymbolErrors extends DiagramErrors<SymbolErrorType> {
  final String symbol;

  // If there is an error specified, return the error type
  SymbolErrorType? get isUnRegistered =>
      isError(SymbolErrorType.unregisteredSymbol);
  SymbolErrorType? get isIllegalSymbol =>
      isError(SymbolErrorType.illegalSymbol);

  SymbolErrors({
    required super.errors,
    required this.symbol,
  });
}
