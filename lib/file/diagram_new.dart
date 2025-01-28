import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay/confirm_overlay.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
import 'package:flutter/material.dart';

class DiagramNew {
  void newDiagram(BuildContext context) async {
    resetProvider();
    if (await confirm("Choose diagram type", context,
        cancle: "NFA", confirm: "DFA")) {
      FileProvider().faType = FAType.dfa;
    } else {
      FileProvider().faType = FAType.nfa;
    }
  }
}
