import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu_item.dart';
import 'package:flutter/material.dart';

class DiagramDiagramMenu extends DiagramMenu {
  const DiagramDiagramMenu({
    super.key,
  });

  @override
  String get label => 'Diagram';

  @override
  List<PopupMenuEntry<AppAction?>> items(BuildContext context) => [
        DiagramMenuItem(
          label: 'states',
        ).build(),
        DiagramMenuItem(
          label: 'transitions',
        ).build(),
        DiagramMenuItem(
          label: 'alphabet',
        ).build(),
      ];
}
