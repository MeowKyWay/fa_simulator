import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardSingleton with ChangeNotifier {
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
