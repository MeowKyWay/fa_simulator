
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

class DiagramDraggingProvider extends DiagramProvider with ChangeNotifier {
  //Singleton
  static final DiagramDraggingProvider _instance =
      DiagramDraggingProvider._internal();
  factory DiagramDraggingProvider() => _instance;
  DiagramDraggingProvider._internal();

  Offset? _startPosition;
  Offset? _endPosition;
  Offset? _topLeft;
  Offset? _bottomRight;
  bool firstMoveFlag = true;

  bool get isDragging => _startPosition != null && _endPosition != null;

  Offset? get startPosition => _startPosition;
  Offset? get endPosition => _endPosition;
  Offset get position {
    if (_topLeft == null || _bottomRight == null) {
      throw Exception("Top left and bottom right must be calculated first");
    }
    if (_startPosition == null || _endPosition == null) {
      throw Exception("Start and end position must be set first");
    }
    return _topLeft! - _startPosition! + _endPosition!;
  }

  Size get size {
    if (_topLeft == null || _bottomRight == null) {
      throw Exception("Top left and bottom right must be calculated first");
    }
    return Size(
      (_topLeft!.dx - _bottomRight!.dx).abs(),
      (_topLeft!.dy - _bottomRight!.dy).abs(),
    );
  }

  Offset get deltaPosition {
    if (_startPosition == null || _endPosition == null) {
      throw Exception("Start and end position must be set first");
    }
    return _endPosition! - _startPosition!;
  }

  set startPosition(Offset? value) {
    _startPosition = value;
    DiagramList().notify();
    notifyListeners();
  }

  set endPosition(Offset? value) {
    _endPosition = value;
    notifyListeners();
  }

  void calculateOffset() {
    // Calculate the top left and bottom right of the focused items
    List<DiagramType> focusItems = DiagramList().focusedItems;
    double top = double.infinity;
    double left = double.infinity;
    double right = double.negativeInfinity;
    double bottom = double.negativeInfinity;

    for (DiagramType item in focusItems) {
      top = top > item.top ? item.top : top;
      left = left > item.left ? item.left : left;
      right = right < item.right ? item.right : right;
      bottom = bottom < item.bottom ? item.bottom : bottom;
    }

    _topLeft = Offset(left, top);
    _bottomRight = Offset(right, bottom);
  }

  @override
  void reset() {
    _startPosition = null;
    _endPosition = null;
    _topLeft = null;
    _bottomRight = null;
    firstMoveFlag = true;
    DiagramList().notify();
    notifyListeners();
  }
}
