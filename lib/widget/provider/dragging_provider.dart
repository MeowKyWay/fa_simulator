import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:flutter/material.dart';

class DraggingProvider with ChangeNotifier {
  //Singleton
  static final DraggingProvider _instance = DraggingProvider._internal();
  DraggingProvider._internal();
  factory DraggingProvider() {
    return _instance;
  }

  String? _draggingItemId;
  Offset? _startPosition;
  Offset? _endPosition;

  //transition
  TransitionPivotType? _pivotType;

  String? get draggingItemId => _draggingItemId;
  Offset? get startPosition => _startPosition;
  Offset? get endPosition => _endPosition;
  TransitionPivotType? get pivotType => _pivotType;

  Offset get deltaOffset {
    if (_startPosition == null || _endPosition == null) {
      return Offset.zero;
    }
    return _endPosition! - _startPosition!;
  }

  set draggingItemId(String? value) {
    _draggingItemId = value;
    notifyListeners();
  }

  set startPosition(Offset? value) {
    _startPosition = value;
    notifyListeners();
  }

  set endPosition(Offset? value) {
    _endPosition = value;
    notifyListeners();
  }

  set pivotType(TransitionPivotType? value) {
    _pivotType = value;
    notifyListeners();
  }

  void reset() {
    _draggingItemId = null;
    _startPosition = null;
    _endPosition = null;
    _pivotType = null;
    notifyListeners();
  }
}