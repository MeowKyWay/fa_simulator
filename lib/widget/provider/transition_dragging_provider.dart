import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:flutter/material.dart';

class TransitionDragingProvider with ChangeNotifier {
  //Singleton
  static final TransitionDragingProvider _instance = TransitionDragingProvider._internal();
  TransitionDragingProvider._internal();
  factory TransitionDragingProvider() {
    return _instance;
  }

  String? _draggingItemId;
  Offset? _startPosition;
  Offset? _endPosition;

  //transition
  TransitionPivotType? _pivotType;
  String? _hoveringStateId;

  String? get draggingItemId => _draggingItemId;
  Offset? get startPosition => _startPosition;
  Offset? get endPosition => _endPosition;
  TransitionPivotType? get pivotType => _pivotType;
  String? get hoveringStateId => _hoveringStateId;

  Offset get deltaOffset {
    if (_startPosition == null || _endPosition == null) {
      return Offset.zero;
    }
    return _endPosition! - _startPosition!;
  }

  set draggingItemId(String? value) {
    _draggingItemId = value;
    DiagramList().notify();
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

  set hoveringStateId(String? value) {
    _hoveringStateId = value;
    notifyListeners();
  }

  void reset() {
    _draggingItemId = null;
    _startPosition = null;
    _endPosition = null;
    _pivotType = null;
    _hoveringStateId = null;
    notifyListeners();
  }

  get isDragging => _draggingItemId != null;
}