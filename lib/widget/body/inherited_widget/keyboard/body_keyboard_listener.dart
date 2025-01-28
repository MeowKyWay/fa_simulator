import 'dart:developer';

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
  Set<LogicalKeyboardKey> pressedModifierKey = {};

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).addListener(() {
        if (!widget.focusNode.hasFocus && FocusScope.of(context).hasFocus) {
          widget.focusNode.requestFocus();
          log("Focus requested");
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardData(
      pressedModifierKey: pressedModifierKey,
      child: Builder(builder: (context) {
        return KeyboardListener(
          focusNode: widget.focusNode,
          onKeyEvent: (value) {
            if (value is KeyDownEvent) {
              if (modifierKeys.contains(value.logicalKey)) {
                setState(() {
                  pressedModifierKey.add(value.logicalKey);
                });
              }
              // if (value.logicalKey == LogicalKeyboardKey.enter) {
              //   handleChar("");
              // } else if (value.character != null) {
              //   handleChar(value.character);
              // }
            } else if (value is KeyUpEvent) {
              setState(() {
                pressedModifierKey.remove(value.logicalKey);
              });
            }
          },
          child: widget.child,
        );
      }),
    );
  }
}
