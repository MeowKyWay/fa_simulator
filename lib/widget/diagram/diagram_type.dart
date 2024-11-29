import 'package:flutter/material.dart';

class DiagramType {
  final String id;
  bool hasFocus;
  String label;

  DiagramType({
    required this.id,
    required this.label,
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
    required super.label,
    super.hasFocus,
    this.isDragging = false,
    this.isRenaming = false,
    this.isHovering = false,
  });
}

class TransitionType extends DiagramType {
  final StateType sourceState;
  final StateType destinationState;
  final bool sourceStateCentered;
  final bool destinationStateCentered;

  final double sourceStateAngle;
  final double destinationStateAngle;

  TransitionType({
    required super.id,
    required super.label,
    super.hasFocus,
    required this.sourceState,
    required this.destinationState,
    required this.sourceStateCentered,
    required this.destinationStateCentered,
    required this.sourceStateAngle,
    required this.destinationStateAngle,
  });
}
