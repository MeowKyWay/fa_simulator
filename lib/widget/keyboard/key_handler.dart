import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/delete_states_action.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:fa_simulator/widget/keyboard/keyboard_singleton.dart';
import 'package:flutter/services.dart';

void handleKey(LogicalKeyboardKey key) {
  if (KeyboardSingleton()
      .modifierKeys
      .contains(LogicalKeyboardKey.controlLeft)) {
    _handleCtrl(key);
    return;
  }
  if (KeyboardSingleton().modifierKeys.contains(LogicalKeyboardKey.altLeft)) {
    _handleAlt(key);
    return;
  }
  _handleKey(key);
}

void _handleCtrl(LogicalKeyboardKey key) {
  switch (key) {
    case LogicalKeyboardKey.keyZ:
      _handleUndoRedo();
    default:
      break;
  }
}

void _handleAlt(LogicalKeyboardKey key) {
  //TODO implement
}

void _handleKey(LogicalKeyboardKey key) {
  //Back space
  if (key == LogicalKeyboardKey.backspace) {
    _handleBackspace();
    return;
  }
}

void _handleBackspace() {
  //Prevent delete a state when renaming
  if (StateList().renamingStateId.isNotEmpty) {
    return;
  }
  List<StateType> focusedStates =
      StateList().states.where((element) => element.hasFocus).toList();
  if (focusedStates.isEmpty) {
    return;
  }
  AppActionDispatcher().execute(DeleteStatesAction(focusedStates));
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
