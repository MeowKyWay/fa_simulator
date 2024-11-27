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
  Offset? _targetStateposition;

  Offset? get startPosition => _startPosition;
  Offset? get endPosition => _targetStateposition ?? _endPosition;
  Offset? get targetStatePosition => _targetStateposition;

  set startPosition(Offset? position) {
    _startPosition = position;
    notifyListeners();
  }

  set endPosition(Offset? position) {
    _endPosition = position;
    notifyListeners();
  }

  set targetStatePosition(Offset? position) {
    _targetStateposition = position;
    notifyListeners();
  }

  void resetPosition() {
    _startPosition = null;
    _endPosition = null;
    _targetStateposition = null;
    notifyListeners();
  }
}
