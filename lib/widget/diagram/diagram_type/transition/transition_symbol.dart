import 'dart:collection';

import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';

extension TransitionSymbol on TransitionType {
  SplayTreeSet<String> get symbols {
    SplayTreeSet<String> symbols = SplayTreeSet<String>();
    List<String> label = this.label.split(',');
    for (String symbol in label) {
      if (symbol.isEmpty) {
        continue;
      }
      symbols.add(symbol.trim());
    }
    return symbols;
  }

  void deleteSymbol(String symbol) {
    label = label.replaceAll(symbol, '');
    label = label.replaceAll(',,', ',');
    label = label.replaceAll(RegExp(r'^,'), '');
    label = label.replaceAll(RegExp(r',$'), '');
    label = label.trim();
  }
}
