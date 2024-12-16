import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu_item.dart';
import 'package:flutter/material.dart';

class DiagramFileMenu extends DiagramMenu {
  const DiagramFileMenu({
    super.key,
  });

  @override
  String get label => 'File';

  @override
  List<PopupMenuEntry> get items => [
        DiagramMenuItem(label: 'New').build(),
        DiagramMenuItem(label: 'Open').build(),
        PopupMenuDivider(height: 1,),
        DiagramMenuItem(label: 'Save').build(),
        DiagramMenuItem(label: 'Save As').build(),
        PopupMenuDivider(height: 1,),
        DiagramMenuItem(label: 'Export').build(),
        DiagramMenuItem(label: 'Import').build(),
      ];
}
