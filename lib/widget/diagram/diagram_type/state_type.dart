import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/file/app_log.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:flutter/material.dart';

class StateType extends DiagramType<StateType> {
  Offset _position;
  bool isInitial = false;
  bool isFinal = false;
  double initialArrowAngle = 3 / 2 * pi;

  StateType({
    super.id,
    required super.label,
    required Offset position,
    this.isInitial = false,
    this.isFinal = false,
    this.initialArrowAngle = pi * (4 / 3),
  }) : _position = position {
    this.position = position;
  }

  set position(Offset position) {
    _position = BodyProvider().getSnappedPosition(position);
  }

  Offset get position => _position;

  @override
  String toString() {
    return {
      'id': id,
      'label': label,
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
    try {
      StateType state = StateType(
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
      AppLog.log(state.toString());
      return state;
    } on Exception catch (e) {
      AppLog.log('Error parsing StateType from JSON: $e');
      throw FormatException('Error parsing StateType from JSON: $e');
    }
  }

  @override
  StateType get clone {
    return StateType(
      id: id,
      label: label,
      position: position,
      isInitial: isInitial,
      isFinal: isFinal,
      initialArrowAngle: initialArrowAngle,
    );
  }

  @override
  int compareTo(StateType other) {
    return stateComparator(this, other);
  }
}

int stateComparator(StateType a, StateType b) {
  int result = a.label.compareTo(b.label);
  if (result == 0) {
    result = a.id.compareTo(b.id);
  }
  return result;
}
