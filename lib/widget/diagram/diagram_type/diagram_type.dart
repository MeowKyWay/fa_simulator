import 'package:flutter/material.dart';

abstract class DiagramType {
  final String id;
  bool hasFocus;
  String label;

  DiagramType({
    required this.id,
    required this.label,
    this.hasFocus = false,
  });

  double get top;
  double get left;
  double get bottom;
  double get right;
}
