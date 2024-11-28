import 'package:flutter/material.dart';

class DiagramType {
  final String id;
  String name;
  bool hasFocus;

  DiagramType({
    required this.id,
    required this.name,
    this.hasFocus = false,
  });
}

class StateType extends DiagramType {
  Offset position;
  bool isDragging;
  bool isRenaming;
  bool isHovering;

  StateType({
    required this.position,
    required super.id,
    required super.name,
    super.hasFocus,
    this.isDragging = false,
    this.isRenaming = false,
    this.isHovering = false,
  });
}

class TransitionType extends DiagramType {
  final StateType from;
  final StateType to;
  final bool centeredFrom;
  final bool centeredTo;

  final double? angleFrom;
  final double? angleTo;

  TransitionType({
    required super.id,
    required super.name,
    super.hasFocus,
    required this.from,
    required this.to,
    required this.centeredFrom,
    required this.centeredTo,
    this.angleFrom,
    this.angleTo,
  });
}
