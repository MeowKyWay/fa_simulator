import 'dart:io';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/diagram/delete_diagrams_action.dart';
import 'package:fa_simulator/action/file/save_diagram_action.dart';
import 'package:fa_simulator/action/file/save_diagram_as_action.dart';
import 'package:fa_simulator/action/intent/copy_paste_intent.dart';
import 'package:fa_simulator/action/intent/diagram_intent.dart';
import 'package:fa_simulator/action/intent/file_intent.dart';
import 'package:fa_simulator/action/intent/rename_intent.dart';
import 'package:fa_simulator/action/intent/undo_redo_intent.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BodyShortcuts extends StatefulWidget {
  final Widget child;

  const BodyShortcuts({
    super.key,
    required this.child,
  });

  @override
  State<BodyShortcuts> createState() => _BodyShortcutsState();
}

class _BodyShortcutsState extends State<BodyShortcuts> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RenamingProvider>(builder: (context, provider, child) {
      return Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          // To prevent shortcuts from being triggered when renaming
          if (provider.renamingItemId == null) ...{
            // Undo and Redo
            _ctrlZ: UndoIntent(),
            _ctrlShiftZ: RedoIntent(),
            // Copy and Paste
            _ctrlC: CopyIntent(),
            _ctrlV: PasteIntent(),
            // File
            _ctrlS: SaveIntent(),
            _ctrlShiftS: SaveAsIntent(),
            _ctrlN: NewIntent(),
            _ctrlO: OpenIntent(),
            // Rename
            _enter: RenameIntent(),
            ..._charActivator,
            // Delete
            _backSpace: DeleteIntent(),
          },
        },
        child: Actions(
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
                throw UnimplementedError();
              },
            ),
            PasteIntent: CallbackAction<PasteIntent>(
              onInvoke: (intent) {
                throw UnimplementedError();
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
            // TODO implement "real" clipboard
            NewIntent: CallbackAction<NewIntent>(
              onInvoke: (intent) {
                throw UnimplementedError();
              },
            ),
            OpenIntent: CallbackAction<OpenIntent>(
              onInvoke: (intent) {
                throw UnimplementedError();
              },
            ),
            RenameIntent: CallbackAction<RenameIntent>(
              onInvoke: (intent) {
                if (DiagramList().focusedItems.length != 1) return null;
                provider.startRename(
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
              },
            ),
          },
          child: widget.child,
        ),
      );
    });
  }

  final _ctrlZ = SingleActivator(
    LogicalKeyboardKey.keyZ,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
  );
  final _ctrlShiftZ = SingleActivator(
    LogicalKeyboardKey.keyZ,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
    shift: true,
  );
  final _ctrlC = SingleActivator(
    LogicalKeyboardKey.keyC,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
  );
  final _ctrlV = SingleActivator(
    LogicalKeyboardKey.keyV,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
  );
  final _ctrlS = SingleActivator(
    LogicalKeyboardKey.keyS,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
  );
  final _ctrlShiftS = SingleActivator(
    LogicalKeyboardKey.keyS,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
    shift: true,
  );
  final _ctrlN = SingleActivator(
    LogicalKeyboardKey.keyN,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
  );
  final _ctrlO = SingleActivator(
    LogicalKeyboardKey.keyO,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
  );
  final _enter = SingleActivator(
    LogicalKeyboardKey.enter,
  );
  final _charActivator = {
    for (int i = 0; i < allCharacter.length; i++)
      CharacterActivator(allCharacter[i]): RenameIntent(
        initialName: allCharacter[i],
      ),
  };
  final _backSpace = SingleActivator(
    LogicalKeyboardKey.backspace,
  );
}

final String allCharacter =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\\';
