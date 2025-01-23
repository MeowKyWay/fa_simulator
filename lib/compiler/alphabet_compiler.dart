enum AlphabetErrorType {
  unregisteredSymbol,
}

class AlphabetCompiler {
  static Map<String, List<AlphabetErrorType>> compile(
    List<String> alphabet,
    List<String> unregisteredAlphabet,
  ) {
    final Map<String, List<AlphabetErrorType>> errors = {};
    for (final symbol in unregisteredAlphabet) {
      errors[symbol] = [];
      errors[symbol]!.add(AlphabetErrorType.unregisteredSymbol);
    }

    return errors;
  }
}
