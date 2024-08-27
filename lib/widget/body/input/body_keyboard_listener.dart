import 'dart:developer';

import 'package:fa_simulator/state_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BodyKeyboardListener extends StatelessWidget {
  final Widget child;
  final FocusNode focusNode;
  const BodyKeyboardListener({
    super.key,
    required this.child,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: focusNode,
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

        if (event is KeyUpEvent) return;
        // Individual key handler
        if (event.logicalKey == LogicalKeyboardKey.backspace) {
          StateList().deleteFocusedStates();
        }
      },
      child: child,
    );
  }
}

class KeyboardSingleton with ChangeNotifier {
  static final KeyboardSingleton _instance =
      KeyboardSingleton._internal(); //Singleton
  KeyboardSingleton._internal();
  factory KeyboardSingleton() {
    return _instance;
  }

  //Keyboard listeners
  final Set<LogicalKeyboardKey> pressedKeys = {};

  void addKey(LogicalKeyboardKey key) {
    pressedKeys.add(key);
    notifyListeners();
  }

  void removeKey(LogicalKeyboardKey key) {
    pressedKeys.remove(key);
    notifyListeners();
  }
}
