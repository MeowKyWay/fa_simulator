import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/copy_paste/paste_action.dart';
import 'package:fa_simulator/action/focus/focus_all_action.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu_item.dart';
import 'package:flutter/material.dart';

class BodyContextMenuRegion extends StatelessWidget {
  final Widget child;

  const BodyContextMenuRegion({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildDivider() {
      return Divider(
        height: 5,
        thickness: 1,
        endIndent: 5,
        indent: 5,
        color: Theme.of(context).colorScheme.outlineVariant,
      );
    }

    return GestureDetector(
      onSecondaryTapUp: (details) {
        DiagramContextMenu.show(
          context: context,
          position: details.globalPosition,
          menu: [
            if (AppActionDispatcher().canUndo) ...[
              DiagramContextMenuItem(
                label: 'Undo',
                onTap: () {
                  DiagramContextMenu.hide();
                  AppActionDispatcher().undo();
                },
              ),
            ],
            if (AppActionDispatcher().canRedo) ...[
              DiagramContextMenuItem(
                label: 'Redo',
                onTap: () {
                  DiagramContextMenu.hide();
                  AppActionDispatcher().redo();
                },
              ),
            ],
            if (AppActionDispatcher().canUndo || AppActionDispatcher().canRedo)
              buildDivider(),
            DiagramContextMenuItem(
              label: 'Paste',
              onTap: () {
                DiagramContextMenu.hide();
                AppActionDispatcher().execute(
                  PasteAction(),
                );
              },
            ),
            buildDivider(),
            DiagramContextMenuItem(
              label: 'Select All',
              onTap: () {
                DiagramContextMenu.hide();
                AppActionDispatcher().execute(
                  FocusAllAction(),
                );
              },
            ),
          ],
        );
      },
      child: child,
    );
  }
}
