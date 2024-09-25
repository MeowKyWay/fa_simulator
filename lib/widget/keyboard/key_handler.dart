import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/delete_states_action.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:fa_simulator/widget/keyboard/keyboard_singleton.dart';
import 'package:flutter/services.dart';

void handleKey(LogicalKeyboardKey key) {
  switch (key) {
    case LogicalKeyboardKey.backspace:
      _handleBackspace();
    case LogicalKeyboardKey.keyZ:
      _handleZ();
    default:
      break;
  }
}

void _handleBackspace() {
  List<StateType> focusedStates =
      StateList().states.where((element) => element.hasFocus).toList();
  if (focusedStates.isEmpty) {
    return;
  }
  AppActionDispatcher().execute(DeleteStatesAction(focusedStates));
}

void _handleZ() {
  // If control is pressed, undo
  if (!KeyboardSingleton()
      .modifierKeys
      .contains(LogicalKeyboardKey.controlLeft)) {
    return;
  }
  // If shift is pressed, redo
  if (KeyboardSingleton().modifierKeys.contains(LogicalKeyboardKey.shiftLeft)) {
    AppActionDispatcher().redo();
    return;
  }
  // Else undo
  AppActionDispatcher().undo();
}
