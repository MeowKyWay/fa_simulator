import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/copy_paste/copy_action.dart';
import 'package:fa_simulator/action/copy_paste/cut_action.dart';
import 'package:fa_simulator/action/diagram/delete_diagrams_action.dart';
import 'package:fa_simulator/action/state/change_state_type_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu_item.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu_toggle.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';

class DiagramContextMenuRegion extends StatelessWidget {
  final Widget child;

  const DiagramContextMenuRegion({
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
            DiagramContextMenuItem(
              label: 'Delete',
              color: Colors.red,
              onTap: () {
                DiagramContextMenu.hide();
                AppActionDispatcher().execute(
                  DeleteDiagramsAction(ids: FocusProvider().focusedItemIds),
                );
              },
            ),
            buildDivider(),
            DiagramContextMenuItem(
              label: 'Cut',
              onTap: () {
                DiagramContextMenu.hide();
                AppActionDispatcher().execute(
                  CutAction(),
                );
              },
            ),
            DiagramContextMenuItem(
              label: 'Copy',
              onTap: () {
                DiagramContextMenu.hide();
                AppActionDispatcher().execute(
                  CopyAction(),
                );
              },
            ),
            if (FocusProvider().isSingleFocus) ...[
              buildDivider(),
              DiagramContextMenuItem(
                label:
                    FocusProvider().isSingleState ? 'Rename' : 'Edit Symbols',
                onTap: () {
                  RenamingProvider().startRename(
                    id: FocusProvider().focusedItemIds.first,
                    initialName: FocusProvider().focusedItems.first.label,
                  );
                },
              ),
              if (FocusProvider().isSingleState) ...[
                buildDivider(),
                DiagramContextMenuToggle(
                  label: 'Initial',
                  value: (FocusProvider().focusedItems.first as StateType)
                      .isInitial,
                  onChanged: (value) {
                    DiagramContextMenu.hide();
                    AppActionDispatcher().execute(
                      ChangeStateTypeAction(
                        id: FocusProvider().focusedItemIds.first,
                        isInitial: value,
                      ),
                    );
                  },
                ),
                DiagramContextMenuToggle(
                  label: 'Final',
                  value:
                      (FocusProvider().focusedItems.first as StateType).isFinal,
                  onChanged: (value) {
                    DiagramContextMenu.hide();
                    AppActionDispatcher().execute(
                      ChangeStateTypeAction(
                        id: FocusProvider().focusedItemIds.first,
                        isFinal: value,
                      ),
                    );
                  },
                ),
              ]
            ],
          ],
        );
      },
      child: child,
    );
  }
}
