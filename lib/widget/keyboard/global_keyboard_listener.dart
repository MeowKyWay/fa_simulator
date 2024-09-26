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
          if (event is KeyDownEvent || event is KeyRepeatEvent) {
            // Add key to pressed keys
            KeyboardSingleton().addKey(event.logicalKey);
            if (event.character != null) {
              KeyboardSingleton().character = event.character;
            }
          } else if (event is KeyUpEvent) {
            // Remove key from pressed keys
            KeyboardSingleton().removeKey(event.logicalKey);
          }
        },
        child: widget.child,
      ),
    );
  }
}
