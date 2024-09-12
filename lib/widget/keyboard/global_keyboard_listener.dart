import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/delete_states_action.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:fa_simulator/widget/keyboard/keyboard_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalKeyboardListener extends StatefulWidget {
  final Widget child;
  const GlobalKeyboardListener({
    super.key,
    required this.child,
  });

  @override
  State<GlobalKeyboardListener> createState() {
    return _GlobalKeyboardListenerState();
  }
}

class _GlobalKeyboardListenerState extends State<GlobalKeyboardListener> {
  @override
  void initState() {
    super.initState();
    KeyboardSingleton().focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    KeyboardSingleton().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        KeyboardSingleton().focusNode.requestFocus();
      },
      child: KeyboardListener(
        focusNode: KeyboardSingleton().focusNode,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            log('Key down: ${event.logicalKey}');
            // Prevent duplicate key presses
            if (KeyboardSingleton().pressedKeys.contains(event.logicalKey)) {
              return;
            }
            // Add key to pressed keys
            KeyboardSingleton().addKey(event.logicalKey);
          } else if (event is KeyUpEvent) {
            // Remove key from pressed keys
            KeyboardSingleton().removeKey(event.logicalKey);
          }

          //Only handle key down events
          //Individually handle key down events for each key
          if (event is KeyUpEvent) return;
          // On backspace
          if (event.logicalKey == LogicalKeyboardKey.backspace) {
            _handleBackspace();
          }
          // On undo or redo
          if (event.logicalKey == LogicalKeyboardKey.keyZ) {
            _handleZ();
          }
        },
        child: widget.child,
      ),
    );
  }

  // Delete every focused state
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
        .pressedKeys
        .contains(LogicalKeyboardKey.controlLeft)) {
      return;
    }
    // If shift is pressed, redo
    if (KeyboardSingleton()
        .pressedKeys
        .contains(LogicalKeyboardKey.shiftLeft)) {
      AppActionDispatcher().redo();
      return;
    }
    // Else undo
    AppActionDispatcher().undo();
  }
}
