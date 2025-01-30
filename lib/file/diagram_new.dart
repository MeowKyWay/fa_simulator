import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay/confirm_overlay.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

class DiagramNew {
  void newDiagram(BuildContext context) async {
    resetProvider();
    if (await confirm('Choose diagram type', context,
        cancle: 'NFA', confirm: 'DFA')) {
      DiagramList().type = AutomataType.dfa;
    } else {
      DiagramList().type = AutomataType.nfa;
    }
  }
}
