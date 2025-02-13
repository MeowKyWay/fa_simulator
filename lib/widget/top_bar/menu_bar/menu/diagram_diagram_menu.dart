import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/diagram/change_diagram_type_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu_item.dart';
import 'package:fa_simulator/widget/keyboard/key_handler/diagram_shortcut.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:flutter/material.dart';

class DiagramDiagramMenu extends DiagramMenu {
  const DiagramDiagramMenu({
    super.key,
    required super.isOpen,
    required super.close,
  });

  @override
  String get label => 'Diagram';

  @override
  List<Widget> items(BuildContext context) => [
        DiagramContextMenuItem(
          label:
              'Switch to ${DiagramList().type == AutomataType.dfa ? 'NFA' : 'DFA'}',
          shortcut: DiagramShortcut().toggleType,
          onTap: () {
            AppActionDispatcher().execute(ChangeDiagramTypeAction(
              type: DiagramList().type == AutomataType.dfa
                  ? AutomataType.nfa
                  : AutomataType.dfa,
            ));
          },
          padding: padding,
          close: close,
        ),
      ];
}
