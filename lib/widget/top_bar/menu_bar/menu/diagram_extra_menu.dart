import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/copy_paste/copy_action.dart';
import 'package:fa_simulator/action/copy_paste/cut_action.dart';
import 'package:fa_simulator/action/copy_paste/paste_action.dart';
import 'package:fa_simulator/action/focus/focus_all_action.dart';
import 'package:fa_simulator/action/focus/unfocus_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/keyboard/key_handler/diagram_shortcut.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu_item.dart';
import 'package:flutter/material.dart';

class DiagramExtraMenu extends DiagramMenu {
  const DiagramExtraMenu({
    super.key,
    required super.isOpen,
  });

  @override
  String get label => 'Edit';

  @override
  List<Widget> items(BuildContext context) => [
        DiagramMenuItem(
          label: 'Undo',
          shortcut: DiagramShortcut().undo,
          action: () {
            AppActionDispatcher().undo();
          },
          enabled: AppActionDispatcher().canUndo,
        ),
        DiagramMenuItem(
          label: 'Redo',
          shortcut: DiagramShortcut().redo,
          action: () {
            AppActionDispatcher().redo();
          },
          enabled: AppActionDispatcher().canRedo,
        ),
        const PopupMenuDivider(
          height: 1,
        ),
        DiagramMenuItem(
          label: 'Cut',
          shortcut: DiagramShortcut().cut,
          action: () {
            AppActionDispatcher().execute(CutAction());
          },
          enabled: FocusProvider().isNotEmpty,
        ),
        DiagramMenuItem(
          label: 'Copy',
          shortcut: DiagramShortcut().copy,
          action: () {
            AppActionDispatcher().execute(CopyAction());
          },
          enabled: FocusProvider().isNotEmpty,
        ),
        DiagramMenuItem(
          label: 'Paste',
          shortcut: DiagramShortcut().paste,
          action: () {
            AppActionDispatcher().execute(PasteAction());
          },
        ),
        const PopupMenuDivider(
          height: 1,
        ),
        DiagramMenuItem(
          label: 'Select All',
          shortcut: DiagramShortcut().selectAll,
          action: () {
            AppActionDispatcher().execute(FocusAllAction());
          },
        ),
        DiagramMenuItem(
          label: 'Select None',
          shortcut: DiagramShortcut().selectNone,
          action: () {
            AppActionDispatcher().execute(UnfocusAction());
          },
        ),
      ];
}
