import 'dart:collection';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';

extension DiagramListAlphabet on DiagramList {
  void addSymbol(String symbol) {
    alphabet.add(symbol);
    notify();
  }

  void addAllAlphabet(Iterable<String> alphabet) {
    this.alphabet.addAll(alphabet);
    notify();
  }

  void removeSymbol(String symbol) {
    alphabet.remove(symbol);
    notify();
  }

  void removeUnregisteredAlphabet() {
    for (TransitionType transition in transitions) {
      for (String symbol in unregisteredAlphabet) {
        transition.removeSymbol(symbol);
      }
    }
    notify();
  }

  SplayTreeSet<String> get unregisteredAlphabet {
    SplayTreeSet<String> alphabet = SplayTreeSet<String>();
    for (TransitionType transition in transitions) {
      alphabet.addAll(transition.symbols);
    }
    alphabet.removeAll(this.alphabet);
    return alphabet;
  }

  SplayTreeSet<String> get symbols {
    SplayTreeSet<String> symbols = SplayTreeSet<String>();
    symbols.addAll(alphabet);
    symbols.addAll(unregisteredAlphabet);
    return symbols;
  }
}
