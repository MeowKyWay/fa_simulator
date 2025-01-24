import 'package:fa_simulator/compiler/error/diagram_error.dart';

enum SymbolErrorType {
  unregisteredSymbol,
}

extension SymbolErrorTypeExtension on SymbolErrorType {
  String get message {
    switch (this) {
      case SymbolErrorType.unregisteredSymbol:
        return 'The symbol is not part of the alphabet.';
    }
  }
}

class SymbolErrors extends DiagramErrors<SymbolErrorType> {
  final String symbol;

  // If there is an error specified, return the error type
  SymbolErrorType? get isUnRegistered =>
      isError(SymbolErrorType.unregisteredSymbol);

  SymbolErrors({
    required super.errors,
    required this.symbol,
  });
}
