import 'package:fa_simulator/widget/keyboard/char_handler.dart';
import 'package:fa_simulator/widget/keyboard/key_handler/key_distributor.dart';
import 'package:fa_simulator/widget/keyboard/key_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardProvider with ChangeNotifier {
  //TODO handle macos and window cmd and ctrl keys
  //Singleton
  static final KeyboardProvider _instance = KeyboardProvider._internal();
  KeyboardProvider._internal() {
    _focusNode = FocusNode();
  }
  factory KeyboardProvider() {
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
  LogicalKeyboardKey? _pressedKey;
  String? _character;
  final Set<LogicalKeyboardKey> _modifierKeys = {};
  
  String? get character => _character;
  Set<LogicalKeyboardKey> get modifierKeys => _modifierKeys;

  void addKey(LogicalKeyboardKey key) {
    if (isModifierKey(key)) {
      if (_modifierKeys.contains(key)) return;
      _modifierKeys.add(key);
      notifyListeners();
      return;
    }
    _pressedKey = key;
    handleKey(key);
    notifyListeners();
  }

  void removeKey(LogicalKeyboardKey key) {
    if (isModifierKey(key)) {
      modifierKeys.remove(key);
      notifyListeners();
      return;
    }
    _pressedKey = null;
    notifyListeners();
  }

  set character(String? value) {
    _character = value;
    if (modifierKeys.isNotEmpty) return;
    handleChar(value);
    notifyListeners();
  }

  bool get isShiftPressed =>
      modifierKeys.contains(LogicalKeyboardKey.shiftLeft) ||
      modifierKeys.contains(LogicalKeyboardKey.shiftRight);
}
