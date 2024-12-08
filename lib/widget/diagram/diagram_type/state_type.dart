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
}
