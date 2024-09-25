import 'package:flutter/services.dart';

List<LogicalKeyboardKey> modifierKeys = [
  LogicalKeyboardKey.controlLeft,
  LogicalKeyboardKey.controlRight,
  LogicalKeyboardKey.altLeft,
  LogicalKeyboardKey.altRight,
  LogicalKeyboardKey.shiftLeft,
  LogicalKeyboardKey.shiftRight,
  LogicalKeyboardKey.metaLeft,
  LogicalKeyboardKey.metaRight,
  LogicalKeyboardKey.fn,
];

bool isModifierKey(LogicalKeyboardKey key) {
  return modifierKeys.contains(key);
}
