import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/file/new_diagram_action.dart';
import 'package:fa_simulator/action/file/open_diagram_action.dart';
import 'package:fa_simulator/action/file/save_diagram_action.dart';
import 'package:fa_simulator/action/file/save_diagram_as_action.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu_item.dart';
import 'package:fa_simulator/widget/keyboard/key_handler/diagram_shortcut.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:flutter/material.dart';

class DiagramFileMenu extends DiagramMenu {
  const DiagramFileMenu({
    super.key,
    required super.isOpen,
  });

  @override
  String get label => 'File';

  @override
  List<Widget> items(BuildContext context) => [
        DiagramContextMenuItem(
          label: 'New',
          shortcut: DiagramShortcut().newFile,
          onTap: () {
            AppActionDispatcher().execute(NewDiagramAction(context: context));
          },
          padding: padding,
        ),
        DiagramContextMenuItem(
          label: 'Open',
          shortcut: DiagramShortcut().open,
          onTap: () {
            AppActionDispatcher().execute(OpenDiagramAction(context: context));
          },
          padding: padding,
        ),
        Divider(
          height: 1,
          indent: 5,
          endIndent: 5,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        DiagramContextMenuItem(
          label: 'Save',
          shortcut: DiagramShortcut().save,
          onTap: () {
            AppActionDispatcher().execute(SaveDiagramAction());
          },
          padding: padding,
        ),
        DiagramContextMenuItem(
          label: 'Save As',
          shortcut: DiagramShortcut().saveAs,
          onTap: () {
            AppActionDispatcher().execute(SaveDiagramAsAction());
          },
          padding: padding,
        ),
      ];
}
