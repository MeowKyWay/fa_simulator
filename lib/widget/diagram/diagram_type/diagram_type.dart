import 'package:flutter/material.dart';

abstract class DiagramType<T extends DiagramType<T>> {
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

  bool isContained(Offset topLeft, Offset bottomRight);

  Map<String, dynamic> toJson();

  T copyWith();

  bool compare(T other) {
    return id == other.id;
  }
}
