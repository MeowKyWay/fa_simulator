import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:flutter/material.dart';

class NewTransitionProvider with ChangeNotifier {
  //Singleton
  static final NewTransitionProvider _instance =
      NewTransitionProvider._internal();
  NewTransitionProvider._internal();
  factory NewTransitionProvider() {
    return _instance;
  }

  Offset? _startPosition;
  Offset? _endPosition;

  bool isHovering = false;
  Offset? _position;
  StateType? _targetState;
  bool _targetStateFlag = false;

  Offset? get startPosition => _startPosition;
  Offset? get endPosition =>
      (_targetStateFlag) ? _targetState!.position : _endPosition;
  StateType? get targetState => _targetState;
  Offset? get position => (_targetStateFlag) ? null : _position;
  bool get targetStateFlag => _targetStateFlag;

  set targetStateFlag(bool value) {
    _targetStateFlag = value;
    notifyListeners();
  }

  set startPosition(Offset? position) {
    _startPosition = position;
    notifyListeners();
  }

  set endPosition(Offset? position) {
    _endPosition = position;
    if (_endPosition != null && _targetState != null) {
      _position = calculatePoint(
        _targetState!.position,
        _endPosition!,
        stateSize / 2,
      );
      _endPosition = _position;
    }
    notifyListeners();
  }

  void resetPosition() {
    _startPosition = null;
    _endPosition = null;
    _targetState = null;
    _position = null;
    _targetStateFlag = false;
    notifyListeners();
  }

  set targetState(StateType? value) {
    _targetState = value;
    notifyListeners();
  }

  set position(Offset? value) {
    _position = value;
    notifyListeners();
  }

  Offset calculatePoint(Offset a, Offset b, double distanceFromA) {
    // Calculate the direction vector
    final direction = b - a;

    // Calculate the magnitude (length) of the direction vector
    final magnitude = direction.distance;

    // Normalize the direction vector
    final unitDirection = direction / magnitude;

    // Calculate the target point
    return a + unitDirection * distanceFromA;
  }
}
