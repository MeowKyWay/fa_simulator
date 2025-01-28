import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/copy_paste/copy_action.dart';
import 'package:fa_simulator/action/copy_paste/paste_action.dart';
import 'package:fa_simulator/action/diagram/delete_diagrams_action.dart';
import 'package:fa_simulator/action/file/new_diagram_action.dart';
import 'package:fa_simulator/action/file/open_diagram_action.dart';
import 'package:fa_simulator/action/file/save_diagram_action.dart';
import 'package:fa_simulator/action/file/save_diagram_as_action.dart';
import 'package:fa_simulator/action/intent/copy_paste_intent.dart';
import 'package:fa_simulator/action/intent/diagram_intent.dart';
import 'package:fa_simulator/action/intent/file_intent.dart';
import 'package:fa_simulator/action/intent/rename_intent.dart';
import 'package:fa_simulator/action/intent/undo_redo_intent.dart';
import 'package:fa_simulator/widget/body/shortcuts/body_shortcuts.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';

class BodyActions extends StatelessWidget {
  const BodyActions({
    super.key,
    required this.widget,
  });

  final BodyShortcuts widget;

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        UndoIntent: CallbackAction<UndoIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().undo();
            return null;
          },
        ),
        RedoIntent: CallbackAction<RedoIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().redo();
            return null;
          },
        ),
        CopyIntent: CallbackAction<CopyIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().execute(CopyAction());
            return null;
          },
        ),
        PasteIntent: CallbackAction<PasteIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().execute(PasteAction());
            return null;
          },
        ),
        SaveIntent: CallbackAction<SaveIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().execute(SaveDiagramAction());
            return null;
          },
        ),
        SaveAsIntent: CallbackAction<SaveAsIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().execute(SaveDiagramAsAction());
            return null;
          },
        ),
        NewIntent: CallbackAction<NewIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().execute(NewDiagramAction(context: context));
            return null;
          },
        ),
        OpenIntent: CallbackAction<OpenIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().execute(OpenDiagramAction(context: context));
            return null;
          },
        ),
        RenameIntent: CallbackAction<RenameIntent>(
          onInvoke: (intent) {
            if (DiagramList().focusedItems.length != 1) return null;
            RenamingProvider().startRename(
              id: DiagramList().focusedItems[0].id,
              initialName: intent.initialName.isEmpty
                  ? DiagramList().focusedItems[0].label
                  : intent.initialName,
            );
            return null;
          },
        ),
        DeleteIntent: CallbackAction<DeleteIntent>(
          onInvoke: (intent) {
            AppActionDispatcher().execute(DeleteDiagramsAction(
              ids: DiagramList().focusedItems.map((e) => e.id).toList(),
            ));
            return null;
          },
        ),
      },
      child: widget.child,
    );
  }
}
