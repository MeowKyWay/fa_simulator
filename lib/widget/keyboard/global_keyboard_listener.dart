
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
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
    KeyboardProvider().focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    KeyboardProvider().dispose();
  }

  @override
  Widget build(BuildContext context) {
    KeyboardProvider().context = context;
    return Listener(
      onPointerDown: (event) {
        KeyboardProvider().focusNode.requestFocus();
      },
      child: KeyboardListener(
        focusNode: KeyboardProvider().focusNode,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent || event is KeyRepeatEvent) {
            // Add key to pressed keys
            KeyboardProvider().addKey(event.logicalKey);
            if (event.character != null && event.logicalKey != LogicalKeyboardKey.backspace) {
              if (event.character!.trim().isNotEmpty) {
                KeyboardProvider().character = event.character;
              }
            }
          } else if (event is KeyUpEvent) {
            // Remove key from pressed keys
            KeyboardProvider().removeKey(event.logicalKey);
          }
        },
        child: widget.child,
      ),
    );
  }
}
