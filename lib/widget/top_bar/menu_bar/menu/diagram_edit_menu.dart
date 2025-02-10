import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/copy_paste/copy_action.dart';
import 'package:fa_simulator/action/copy_paste/cut_action.dart';
import 'package:fa_simulator/action/copy_paste/paste_action.dart';
import 'package:fa_simulator/action/focus/focus_all_action.dart';
import 'package:fa_simulator/action/focus/unfocus_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu_item.dart';
import 'package:fa_simulator/widget/keyboard/key_handler/diagram_shortcut.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_menu.dart';
import 'package:flutter/material.dart';

class DiagramEditMenu extends DiagramMenu {
  const DiagramEditMenu({
    super.key,
    required super.isOpen,
    required super.close,
  });

  @override
  String get label => 'Edit';

  @override
  List<Widget> items(BuildContext context) => [
        DiagramContextMenuItem(
          label: 'Undo',
          shortcut: DiagramShortcut().undo,
          onTap: () {
            AppActionDispatcher().undo();
          },
          enabled: AppActionDispatcher().canUndo,
          padding: padding,
          close: close,
        ),
        DiagramContextMenuItem(
          label: 'Redo',
          shortcut: DiagramShortcut().redo,
          onTap: () {
            AppActionDispatcher().redo();
          },
          enabled: AppActionDispatcher().canRedo,
          padding: padding,
          close: close,
        ),
        Divider(
          height: 1,
          indent: 5,
          endIndent: 5,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        DiagramContextMenuItem(
          label: 'Cut',
          shortcut: DiagramShortcut().cut,
          onTap: () {
            AppActionDispatcher().execute(CutAction());
          },
          enabled: FocusProvider().isNotEmpty,
          padding: padding,
          close: close,
        ),
        DiagramContextMenuItem(
          label: 'Copy',
          shortcut: DiagramShortcut().copy,
          onTap: () {
            AppActionDispatcher().execute(CopyAction());
          },
          enabled: FocusProvider().isNotEmpty,
          padding: padding,
          close: close,
        ),
        DiagramContextMenuItem(
          label: 'Paste',
          shortcut: DiagramShortcut().paste,
          onTap: () {
            AppActionDispatcher().execute(PasteAction());
          },
          padding: padding,
          close: close,
        ),
        Divider(
          height: 1,
          indent: 5,
          endIndent: 5,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        DiagramContextMenuItem(
          label: 'Select All',
          shortcut: DiagramShortcut().selectAll,
          onTap: () {
            AppActionDispatcher().execute(FocusAllAction());
          },
          padding: padding,
          close: close,
        ),
        DiagramContextMenuItem(
          label: 'Select None',
          shortcut: DiagramShortcut().selectNone,
          onTap: () {
            AppActionDispatcher().execute(UnfocusAction());
          },
          padding: padding,
          close: close,
        ),
      ];
}
