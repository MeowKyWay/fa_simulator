import 'dart:developer';

import 'package:fa_simulator/action/action_dispatcher.dart';
import 'package:fa_simulator/state_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BodyKeyboardListener extends StatelessWidget {
  final Widget child;
  const BodyKeyboardListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: KeyboardSingleton()._focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
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
        // On enter
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          _handleEnter();
        }
        // On undo or redo
        if (event.logicalKey == LogicalKeyboardKey.keyZ) {
          _handleZ();
        }
      },
      child: child,
    );
  }

  // Delete every focused state
  void _handleBackspace() {
    StateList().deleteFocusedStates();
  }

  // If only one state is focused, set isRenaming to true
  void _handleEnter() {
    // If only one state is focused, start renaming
    if (StateList().states.where((element) => element.hasFocus).length == 1) {
      StateList().startRename(
          StateList().states.firstWhere((element) => element.hasFocus).id);
    }
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

class KeyboardSingleton with ChangeNotifier {
  //Singleton
  static final KeyboardSingleton _instance = KeyboardSingleton._internal();
  KeyboardSingleton._internal();
  factory KeyboardSingleton() {
    return _instance;
  }

  final FocusNode _focusNode = FocusNode();

  //Keyboard listeners
  final Set<LogicalKeyboardKey> pressedKeys = {};

  void requestFocus() {
    _focusNode.requestFocus();
  }

  void addKey(LogicalKeyboardKey key) {
    pressedKeys.add(key);
    notifyListeners();
  }

  void removeKey(LogicalKeyboardKey key) {
    pressedKeys.remove(key);
    notifyListeners();
  }
}
