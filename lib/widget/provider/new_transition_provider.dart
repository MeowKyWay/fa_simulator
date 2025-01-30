import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

class NewTransitionProvider extends DiagramProvider with ChangeNotifier {
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

  StateType? _hoveringState;

  bool _isDraggingNewTransition = false;

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

  set hoveringState(StateType? state) {
    _hoveringState = state;
    notifyListeners();
  }

  set isDraggingNewTransition(bool value) {
    _isDraggingNewTransition = value;
    DiagramList().notify();
    notifyListeners();
  }

  set draggingPosition(Offset? position) {
    _draggingPosition = position;
    notifyListeners();
  }

  @override
  void reset() {
    _sourceState = null;
    _destinationState = null;
    _hoveringState = null;
    _draggingPosition = null;
    isDraggingNewTransition = false;
    notifyListeners();
  }

  //getter
  StateType? get sourceState => _sourceState;
  StateType? get destinationState => _destinationState;
  StateType? get hoveringState => _hoveringState;
  bool get isDraggingNewTransition => _isDraggingNewTransition;
  Offset? get draggingPosition => _draggingPosition;

  Offset? get sourceStatePosition {
    if (_sourceState == null) {
      return null;
    }
    return _sourceState!.position;
  }

  Offset? get destinationStatePosition {
    if (_destinationState == null) {
      return null;
    }
    return _destinationState!.position;
  }
}
