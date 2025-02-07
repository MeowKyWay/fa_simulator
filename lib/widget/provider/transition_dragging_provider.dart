import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

class TransitionDraggingProvider extends DiagramProvider with ChangeNotifier {
  //Singleton
  static final TransitionDraggingProvider _instance =
      TransitionDraggingProvider._internal();
  TransitionDraggingProvider._internal();
  factory TransitionDraggingProvider() {
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

  double get newLoopAngle {
    if (_pivotType == TransitionPivotType.loop) {
      return (_endPosition! -
              DiagramList().transition(_draggingItemId!).sourceState!.position)
          .direction;
    }
    return 0;
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

  @override
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
