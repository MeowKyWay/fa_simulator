import 'package:fa_simulator/widget/components/interface/jsonable.dart';
import 'package:flutter/material.dart';

enum DiagramTypeEnum {
  state,
  transition,
}

abstract class DiagramType<T extends DiagramType<T>>
    implements Comparable<T>, Jsonable {
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

  T copyWith();

  bool compare(T other) {
    return id == other.id;
  }

  factory DiagramType.fromJson(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
