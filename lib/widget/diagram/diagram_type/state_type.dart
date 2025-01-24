import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:flutter/material.dart';

class StateType extends DiagramType<StateType> {
  Offset position;
  bool isInitial = false;
  bool isFinal = false;
  double initialArrowAngle = 0;

  StateType({
    required this.position,
    required super.id,
    required super.label,
    this.isInitial = false,
    this.isFinal = false,
    this.initialArrowAngle = 0,
    super.hasFocus,
  });

  List<String> get transitionIds {
    return DiagramList()
        .transitions
        .where((t) => t.sourceStateId == id || t.destinationStateId == id)
        .map((t) => t.id)
        .toList();
  }

  List<String> get outgoingTransitionIds {
    return DiagramList()
        .transitions
        .where((t) => t.sourceStateId == id)
        .map((t) => t.id)
        .toList();
  }

  List<String> get incomingTransitionIds {
    return DiagramList()
        .transitions
        .where((t) => t.destinationStateId == id)
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
  int get hashCode =>
      id.hashCode ^
      label.hashCode ^
      position.hashCode ^
      isInitial.hashCode ^
      isFinal.hashCode ^
      initialArrowAngle.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // Check for identical references
    if (other is StateType) {
      return id == other.id &&
          label == other.label &&
          position == other.position &&
          isInitial == other.isInitial &&
          isFinal == other.isFinal &&
          initialArrowAngle == other.initialArrowAngle;
    }
    return false;
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
      'isStartState': isInitial,
      'isAccpetState': isFinal,
      'startArrowAngle': initialArrowAngle,
    };
  }

  @override
  factory StateType.fromJson(Map<String, dynamic> json) {
    return StateType(
      id: json['id'],
      label: json['label'],
      position: Offset(
        json['position']['dx'],
        json['position']['dy'],
      ),
      isInitial: json['isStartState'],
      isFinal: json['isAccpetState'],
      initialArrowAngle: json['startArrowAngle'],
    );
  }

  @override
  StateType copyWith() {
    return StateType(
      id: id,
      label: label,
      position: position,
      isInitial: isInitial,
      isFinal: isFinal,
      initialArrowAngle: initialArrowAngle,
    );
  }
}

int stateComparator(StateType a, StateType b) {
  return a.label.compareTo(b.label);
}