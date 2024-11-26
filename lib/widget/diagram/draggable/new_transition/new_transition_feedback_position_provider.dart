import 'package:flutter/material.dart';

class NewTransitionFeedbackPositionProvider with ChangeNotifier {
  //Singleton
  static final NewTransitionFeedbackPositionProvider _instance =
      NewTransitionFeedbackPositionProvider._internal();
  NewTransitionFeedbackPositionProvider._internal();
  factory NewTransitionFeedbackPositionProvider() {
    return _instance;
  }

  Offset? _startPosition;
  Offset? _endPosition;

  Offset? get startPosition => _startPosition;
  Offset? get endPosition => _endPosition;

  set startPosition(Offset? position) {
    _startPosition = position;
    notifyListeners();
  }

  set endPosition(Offset? position) {
    _endPosition = position;
    notifyListeners();
  }

  void resetPosition() {
    _startPosition = null;
    _endPosition = null;
    notifyListeners();
  }
}
