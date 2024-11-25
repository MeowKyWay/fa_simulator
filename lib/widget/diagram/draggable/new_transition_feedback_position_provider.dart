import 'package:flutter/material.dart';

class NewTransitionFeedbackPositionProvider with ChangeNotifier {
  //Singleton
  static final NewTransitionFeedbackPositionProvider _instance =
      NewTransitionFeedbackPositionProvider._internal();
  NewTransitionFeedbackPositionProvider._internal();
  factory NewTransitionFeedbackPositionProvider() {
    return _instance;
  }

  Offset? _position;

  void updatePosition(Offset position) {
    _position = position;
    notifyListeners();
  }

  Offset? get position => _position;

  void resetPosition() {
    _position = null;
    notifyListeners();
  }
}
