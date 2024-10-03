import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/copy_paste/copy_action.dart';
import 'package:fa_simulator/action/copy_paste/paste_action.dart';
import 'package:fa_simulator/widget/keyboard/keyboard_singleton.dart';
import 'package:flutter/services.dart';

void handleCtrl(LogicalKeyboardKey key) {
  switch (key) {
    case LogicalKeyboardKey.keyZ:
      _handleUndoRedo();
    case LogicalKeyboardKey.keyC:
      _handleCopy();
    case LogicalKeyboardKey.keyV:
      _handlePaste();
    default:
      break;
  }
}

void _handleUndoRedo() {
  if (!KeyboardSingleton().focusNode.hasPrimaryFocus) return;
  // If shift is pressed, redo
  if (KeyboardSingleton().modifierKeys.contains(LogicalKeyboardKey.shiftLeft)) {
    AppActionDispatcher().redo();
    return;
  }
  // Else undo
  AppActionDispatcher().undo();
}

void _handleCopy() {
  log('Copy');
  AppActionDispatcher().execute(CopyAction());
}

void _handlePaste() {
  log('Paste');
  AppActionDispatcher().execute(PasteAction());
}
