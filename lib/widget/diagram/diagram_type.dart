import 'package:flutter/material.dart';

class DiagramType {
  final String id;
  String name;

  DiagramType({
    required this.id,
    required this.name,
  });
}

class StateType extends DiagramType {
  Offset position;
  bool hasFocus;
  bool isDragging;
  bool isRenaming;

  StateType({
    required this.position,
    required super.id,
    required super.name,
    this.hasFocus = false,
    this.isDragging = false,
    this.isRenaming = false,
  });
}

class TransitionType extends DiagramType {
  final StateType from;
  final StateType to;

  TransitionType({
    required super.id,
    required super.name,
    required this.from,
    required this.to,
  });
}
