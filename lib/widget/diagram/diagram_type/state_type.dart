import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:flutter/material.dart';

class StateType extends DiagramType {
  Offset position;

  StateType({
    required this.position,
    required super.id,
    required super.label,
    super.hasFocus,
  });

  List<String> get transitionIds {
    return DiagramList()
        .transitions
        .where((t) => t.sourceStateId == id || t.destinationStateId == id)
        .map((t) => t.id)
        .toList();
  }

  @override
  String toString() {
    return {
      'id': id,
      'label': label,
      'position': position,
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'state',
      'id': id,
      'label': label,
      'position': {
        'dx': position.dx,
        'dy': position.dy,
      },
    };
  }

  factory StateType.fromJson(Map<String, dynamic> json) {
    return StateType(
      id: json['id'],
      label: json['label'],
      position: Offset(
        json['position']['dx'],
        json['position']['dy'],
      ),
    );
  }
}
