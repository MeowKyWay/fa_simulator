import 'package:fa_simulator/widget/keyboard/key_handler.dart';
import 'package:fa_simulator/widget/keyboard/key_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardSingleton with ChangeNotifier {
  //TODO improve keyboard handling
  //Singleton
  static final KeyboardSingleton _instance = KeyboardSingleton._internal();
  KeyboardSingleton._internal() {
    _focusNode = FocusNode();
  }
  factory KeyboardSingleton() {
    return _instance;
  }

  late FocusNode _focusNode;
  FocusNode get focusNode => _focusNode;

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  //Keyboard listeners
  LogicalKeyboardKey? pressedKey;
  final Set<LogicalKeyboardKey> modifierKeys = {};

  void addKey(LogicalKeyboardKey key) {
    if (isModifierKey(key)) {
      if (modifierKeys.contains(key)) return;
      modifierKeys.add(key);
      return;
    }
    pressedKey = key;
    handleKey(key);
    notifyListeners();
  }

  void removeKey(LogicalKeyboardKey key) {
    if (isModifierKey(key)) {
      modifierKeys.remove(key);
      return;
    }
    pressedKey = null;
    notifyListeners();
  }
}
