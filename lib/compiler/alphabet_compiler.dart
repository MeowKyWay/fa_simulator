enum AlphabetError {
  unregisteredAlphabet,
}

class AlphabetCompiler {
  static Map<String, List<AlphabetError>> compile(
    List<String> alphabet,
    List<String> unregisteredAlphabet,
  ) {
    final Map<String, List<AlphabetError>> errors = {};

    for (final symbol in alphabet) {
      errors[symbol] = [];

      // If symbol is not registered in the alphabet, add unregistered alphabet error
      if (!alphabet.contains(symbol)) {
        errors[symbol]!.add(AlphabetError.unregisteredAlphabet);
      }
    }

    return errors;
  }
}
