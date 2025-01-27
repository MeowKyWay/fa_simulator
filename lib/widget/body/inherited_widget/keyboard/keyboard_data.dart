import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardData extends InheritedWidget {
  final Set<LogicalKeyboardKey> pressedModifierKey;

  bool get isCtrlPressed =>
      pressedModifierKey.contains(LogicalKeyboardKey.controlLeft) ||
      pressedModifierKey.contains(LogicalKeyboardKey.controlRight);
  bool get isAltPressed =>
      pressedModifierKey.contains(LogicalKeyboardKey.altLeft) ||
      pressedModifierKey.contains(LogicalKeyboardKey.altRight);
  bool get isShiftPressed =>
      pressedModifierKey.contains(LogicalKeyboardKey.shiftLeft) ||
      pressedModifierKey.contains(LogicalKeyboardKey.shiftRight);
  bool get isMetaPressed =>
      pressedModifierKey.contains(LogicalKeyboardKey.metaLeft) ||
      pressedModifierKey.contains(LogicalKeyboardKey.metaRight);

  const KeyboardData({
    super.key,
    required this.pressedModifierKey,
    required super.child,
  });

  static KeyboardData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<KeyboardData>();
  }

  @override
  bool updateShouldNotify(KeyboardData oldWidget) {
    // Return true when the data has changed and needs to notify dependent widgets
    return pressedModifierKey.difference(oldWidget.pressedModifierKey).isEmpty;
  }
}
