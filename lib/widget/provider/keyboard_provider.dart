import 'dart:io';

import 'package:fa_simulator/widget/keyboard/char_handler.dart';
import 'package:fa_simulator/widget/keyboard/key_handler/key_distributor.dart';
import 'package:fa_simulator/widget/keyboard/key_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardProvider extends DiagramProvider with ChangeNotifier {
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
  LogicalKeyboardKey? get pressedKey => _pressedKey;

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

  bool get isCtrlPressed {
    if (Platform.isMacOS) {
      return modifierKeys.contains(LogicalKeyboardKey.metaLeft) ||
          modifierKeys.contains(LogicalKeyboardKey.metaRight);
    }
    return modifierKeys.contains(LogicalKeyboardKey.controlLeft) ||
        modifierKeys.contains(LogicalKeyboardKey.controlRight);
  }

  @override
  void reset() {
    _pressedKey = null;
    _character = null;
    _modifierKeys.clear();
    notifyListeners();
  }
}
