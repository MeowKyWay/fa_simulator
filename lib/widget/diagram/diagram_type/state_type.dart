import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:flutter/material.dart';

class StateType extends DiagramType {
  Offset position;
  bool isDragging;
  bool isRenaming;
  bool isHovering;

  StateType({
    required this.position,
    required super.id,
    required super.label,
    super.hasFocus,
    this.isDragging = false,
    this.isRenaming = false,
    this.isHovering = false,
  });

  @override
  String toString() {
    return {
      'id': id,
      'label': label,
      'position': position,
      'isDragging': isDragging,
      'isRenaming': isRenaming,
      'isHovering': isHovering,
    }.toString();
  }

  @override
  double get top => position.dy - stateSize / 2;
  @override
  double get left => position.dx - stateSize / 2;
  @override
  double get bottom => position.dy + stateSize / 2;
  @override
  double get right => position.dx + stateSize / 2;

  @override
  bool isContained(Offset topLeft, Offset bottomRight) {
    return topLeft.dx < left &&
        topLeft.dy < top &&
        bottomRight.dx > right &&
        bottomRight.dy > bottom;
  }
}
