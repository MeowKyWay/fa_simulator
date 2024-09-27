import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:flutter/material.dart';

class FeedbackPositionProvider with ChangeNotifier {
  //Singleton
  static final FeedbackPositionProvider _instance =
      FeedbackPositionProvider._internal();
  FeedbackPositionProvider._internal();
  factory FeedbackPositionProvider() {
    return _instance;
  }

  Offset? _position;
  Offset? _startPosition;

  Offset? previousPosition;

  Offset? get position => _position;
  Offset? get startPosition => _startPosition;

  set startPosition(Offset? startPosition) {
    _startPosition = startPosition;
    notifyListeners();
  }

  Size? _size;

  set size(Size? size) {
    _size = size;
    notifyListeners();
  }

  Size? get size => _size;

  void updatePosition(Offset position) {
    // position is relative to the start position
    _position = BodySingleton().getSnappedPosition(_startPosition! + position);
    if (_position == previousPosition) {
      return;
    }
    previousPosition = _position;
    notifyListeners();
  }

  void reset() {
    _position = null;
    _startPosition = null;
    _size = null;
    notifyListeners();
  }
}
