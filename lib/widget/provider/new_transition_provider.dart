import 'dart:math';

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

  StateType? _sourceState;
  StateType? _destinationState;

  bool destinationStateFlag = false;

  bool? _sourceStateCentered;
  bool? _destinationStateCentered;

  double? _sourceStateAngle;
  double? _destinationStateAngle;

  StateType? _hoveringState;
  double? _hoveringStateAngle;

  bool isDraggingNewTransition = false;

  Offset? _draggingPosition;

  //setter
  set sourceState(StateType? state) {
    _sourceState = state;
    notifyListeners();
  }
  set destinationState(StateType? state) {
    _destinationState = state;
    notifyListeners();
  }
  set sourceStateCentered(bool? centered) {
    _sourceStateCentered = centered;
    notifyListeners();
  }
  set destinationStateCentered(bool? centered) {
    _destinationStateCentered = centered;
    notifyListeners();
  }
  set sourceStateAngle(double? angle) {
    _sourceStateAngle = angle;
    notifyListeners();
  }
  set destinationStateAngle(double? angle) {
    _destinationStateAngle = angle;
    notifyListeners();
  }
  set hoveringState(StateType? state) {
    _hoveringState = state;
    notifyListeners();
  }
  set hoveringStateAngle(double? angle) {
    _hoveringStateAngle = angle;
    notifyListeners();
  }
  set draggingPosition(Offset? position) {
    _draggingPosition = position;
    notifyListeners();
  }

  void reset() {
    _sourceState = null;
    _destinationState = null;
    _sourceStateCentered = null;
    _destinationStateCentered = null;
    _sourceStateAngle = null;
    _destinationStateAngle = null;
    _hoveringState = null;
    _hoveringStateAngle = null;
    _draggingPosition = null;
    isDraggingNewTransition = false;
    notifyListeners();
  }

  //getter
  StateType? get sourceState => _sourceState;
  StateType? get destinationState => _destinationState;
  bool get sourceStateCentered => _sourceStateCentered ?? false;
  bool get destinationStateCentered => _destinationStateCentered ?? false;
  double get sourceStateAngle => _sourceStateAngle ?? 0;
  double get destinationStateAngle => _destinationStateAngle ?? 0;
  StateType? get hoveringState => _hoveringState;
  double get hoveringStateAngle => _hoveringStateAngle ?? 0;
  Offset? get draggingPosition => _draggingPosition;

  Offset? get buttonPosition {
    if (_hoveringState == null || _hoveringStateAngle == null) {
      return null;
    }
    return offsetByAngleAndDistance(_hoveringState!.position, _hoveringStateAngle!, stateSize / 2);
  }

  Offset? get sourcePosition {
    if (_sourceState == null) {
      return null;
    }
    if (_sourceStateCentered == true) {
      return _sourceState!.position;
    }
    if (_sourceStateAngle == null) {
      throw Exception('Source state angle is null');
    }
    return offsetByAngleAndDistance(_sourceState!.position, _sourceStateAngle!, stateSize / 2);
  }

  Offset? get destinationPosition {
    if (_destinationState == null) {
      return null;
    }
    if (_destinationStateCentered == true) {
      return _destinationState!.position;
    }
    if (_destinationStateAngle == null) {
      throw Exception('Destination state angle is null');
    }
    return offsetByAngleAndDistance(_destinationState!.position, _destinationStateAngle!, stateSize / 2);
  }

  Offset offsetByAngleAndDistance(
      Offset startPoint, double angle, double distance) {

    // Calculate the new x and y coordinates
    final double x = startPoint.dx + distance * cos(angle);
    final double y = startPoint.dy + distance * sin(angle);

    return Offset(x, y);
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
