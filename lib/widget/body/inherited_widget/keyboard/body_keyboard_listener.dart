import 'package:fa_simulator/widget/body/inherited_widget/keyboard/keyboard_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BodyKeyboardListener extends StatefulWidget {
  final Widget child;
  final FocusNode focusNode;

  const BodyKeyboardListener({
    super.key,
    required this.focusNode,
    required this.child,
  });

  @override
  State<BodyKeyboardListener> createState() => _BodyKeyboardListenerState();
}

class _BodyKeyboardListenerState extends State<BodyKeyboardListener> {
  final Set<LogicalKeyboardKey> modifierKeys = {
    LogicalKeyboardKey.controlLeft,
    LogicalKeyboardKey.controlRight,
    LogicalKeyboardKey.altLeft,
    LogicalKeyboardKey.altRight,
    LogicalKeyboardKey.shiftLeft,
    LogicalKeyboardKey.shiftRight,
    LogicalKeyboardKey.metaLeft,
    LogicalKeyboardKey.metaRight,
  };

  @override
  Widget build(BuildContext context) {
    return KeyboardData(
      child: Builder(
        builder: (context) {
          return KeyboardListener(
            focusNode: widget.focusNode,
            onKeyEvent: (value) {
              if (value is KeyDownEvent) {
                if (modifierKeys.contains(value.logicalKey)) {
                  KeyboardData.of(context)!
                      .pressedModifierKey
                      .add(value.logicalKey);
                }
              } else if (value is KeyUpEvent) {
                KeyboardData.of(context)!
                    .pressedModifierKey
                    .remove(value.logicalKey);
              }
            },
            child: widget.child,
          );
        }
      ),
    );
  }
}
