import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/action/file/open_diagram_action.dart';
import 'package:fa_simulator/action/file/save_diagram_action.dart';
import 'package:fa_simulator/action/file/save_diagram_as_action.dart';
import 'package:fa_simulator/widget/keyboard/key_handler/diagram_shortcut.dart';
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
  List<PopupMenuEntry<AppAction?>> get items => [
        DiagramMenuItem(
          label: 'New',
          shortcut: DiagramShortcut().newFile,
        ).build(),
        DiagramMenuItem(
          label: 'Open',
          shortcut: DiagramShortcut().open,
          action: OpenDiagramAction(),
        ).build(),
        const PopupMenuDivider(
          height: 1,
        ),
        DiagramMenuItem(
          label: 'Save',
          shortcut: DiagramShortcut().save,
          action: SaveDiagramAction(),
        ).build(),
        DiagramMenuItem(
          label: 'Save As',
          shortcut: DiagramShortcut().saveAs,
          action: SaveDiagramAsAction(),
        ).build(),
        const PopupMenuDivider(
          height: 1,
        ),
        DiagramMenuItem(
          label: 'Export',
          enabled: false,
        ).build(),
        DiagramMenuItem(
          label: 'Import',
          enabled: false,
        ).build(),
      ];
}
