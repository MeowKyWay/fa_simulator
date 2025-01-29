import 'dart:collection';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_character.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_symbol.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';

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
        transition.deleteSymbol(symbol);
      }
    }
    notify();
  }

  void removeIllegalAlphabet() {
    for (TransitionType transition in transitions) {
      for (String symbol in illegalAlphabet) {
        transition.deleteSymbol(symbol);
      }
    }
    notify();
  }

  SplayTreeSet<String> get alphabetFromTransitions {
    SplayTreeSet<String> alphabet = SplayTreeSet<String>();
    for (TransitionType transition in transitions) {
      alphabet.addAll(transition.symbols);
    }
    return alphabet;
  }

  SplayTreeSet<String> get allAlphabet {
    SplayTreeSet<String> alphabet = SplayTreeSet<String>();
    alphabet.addAll(this.alphabet);
    alphabet.addAll(unregisteredAlphabet);
    alphabet.addAll(illegalAlphabet);
    return alphabet;
  }

  SplayTreeSet<String> get unregisteredAlphabet {
    SplayTreeSet<String> alphabet = alphabetFromTransitions;
    alphabet.removeAll(this.alphabet);
    if (FileProvider().faType == FAType.dfa) {
      alphabet.removeWhere((element) => element == DiagramCharacter.epsilon);
    }
    return alphabet;
  }

  SplayTreeSet<String> get illegalAlphabet {
    SplayTreeSet<String> alphabet = alphabetFromTransitions;
    alphabet.removeAll(this.alphabet);
    alphabet.removeAll(unregisteredAlphabet);
    return alphabet;
  }
}
