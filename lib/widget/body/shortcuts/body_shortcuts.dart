import 'dart:io';

import 'package:fa_simulator/action/intent/copy_paste_intent.dart';
import 'package:fa_simulator/action/intent/diagram_intent.dart';
import 'package:fa_simulator/action/intent/file_intent.dart';
import 'package:fa_simulator/action/intent/rename_intent.dart';
import 'package:fa_simulator/action/intent/select_intent.dart';
import 'package:fa_simulator/action/intent/undo_redo_intent.dart';
import 'package:fa_simulator/widget/body/shortcuts/body_actions.dart';
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
            _ctrlX: CutIntent(),
            _ctrlC: CopyIntent(),
            _ctrlV: PasteIntent(),
            // Select All
            _ctrlA: SelectAllIntent(),
            _ctrlShiftA: SelectNoneIntent(),
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
        child: BodyActions(widget: widget),
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
  final _ctrlX = SingleActivator(
    LogicalKeyboardKey.keyX,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
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
  final _ctrlA = SingleActivator(
    LogicalKeyboardKey.keyA,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
  );
  final _ctrlShiftA = SingleActivator(
    LogicalKeyboardKey.keyA,
    control: !Platform.isMacOS,
    meta: Platform.isMacOS,
    shift: true,
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
