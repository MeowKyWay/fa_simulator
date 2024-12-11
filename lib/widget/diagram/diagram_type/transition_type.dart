import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class TransitionType extends DiagramType {
  String? sourceStateId;
  String? destinationStateId;

  Offset? sourcePosition;
  Offset? destinationPosition;

  bool isCurved;

  TransitionType({
    required super.id,
    required super.label,
    super.hasFocus,
    this.sourceStateId,
    this.destinationStateId,
    this.sourcePosition,
    this.destinationPosition,
    this.isCurved = false,
  }) : super() {
    // Validation logic moved to constructor body
    if ((sourcePosition ?? sourceStateId) == null) {
      throw ArgumentError(
          "Either sourcePosition or sourceState must be provided");
    }

    if ((destinationPosition ?? destinationStateId) == null) {
      throw ArgumentError(
          "Either destinationPosition or destinationState must be provided");
    }
  }

  Path get path {
    Offset start = startButtonPosition;
    Offset end = endButtonPosition;
    if (isCurved && sourceState != null && destinationState != null) {
      // Calculate the center of the control points
      Offset controlPoint = this.controlPoint;

      return Path()
        ..moveTo(start.dx, start.dy)
        ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, end.dx, end.dy);
    }

    return Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);
  }

  StateType? get sourceState {
    if (sourceStateId == null) {
      return null;
    }
    return DiagramList().state(sourceStateId!);
  }

  StateType? get destinationState {
    if (destinationStateId == null) {
      return null;
    }
    return DiagramList().state(destinationStateId!);
  }

  Offset get startPosition {
    // Does not have source state
    if (sourcePosition != null) {
      return sourcePosition!;
    }
    return sourceState!.position;
  }

  Offset get endPosition {
    // Does not have destination state
    if (destinationPosition != null) {
      return destinationPosition!;
    }
    return destinationState!.position;
  }

  Offset get startButtonPosition {
    if (sourcePosition != null) {
      return sourcePosition!;
    }
    if (isCurved && sourceState != null && destinationState != null) {
      return calculateNewPoint(
        sourceState!.position,
        stateSize / 2,
        startAngle + pi - (pi / 12),
      );
    }
    return calculateNewPoint(
      sourceState!.position,
      stateSize / 2,
      startAngle + pi,
    );
  }

  Offset get endButtonPosition {
    if (destinationPosition != null) {
      return destinationPosition!;
    }
    if (isCurved && sourceState != null && destinationState != null) {
      return calculateNewPoint(
        destinationState!.position,
        stateSize / 2,
        endAngle + pi + (pi / 12),
      );
    }
    return calculateNewPoint(
      destinationState!.position,
      stateSize / 2,
      endAngle + pi,
    );
  }

  double get startAngle {
    return (startPosition - endPosition).direction;
  }

  double get endAngle {
    return (endPosition - startPosition).direction;
  }

  Offset get controlPoint {
    return calculateNewPoint(
        (startPosition + endPosition) / 2, stateSize / 2, startAngle + pi / 2);
  }

  double get arrowAngle {
    if (!isCurved) {
      return endAngle + pi;
    }
    // Calculate the tangent vector at the end of the curve
    double dx = endButtonPosition.dx - controlPoint.dx;
    double dy = endButtonPosition.dy - controlPoint.dy;

    // Calculate the angle using atan2 (returns the angle in radians)
    return atan2(dy, dx) + pi;
  }

  void resetSourceState() {
    if (sourcePosition == null) {
      throw Exception(
          "Source position must be provided before reseting the source state");
    }
    sourceStateId = null;
    isCurved = false;
  }

  void resetDestinationState() {
    if (destinationPosition == null) {
      throw Exception(
          "Destination position must be provided before reseting the destination state");
    }
    destinationStateId = null;
    isCurved = false;
  }

  void resetSourcePosition() {
    if (sourceState == null) {
      throw Exception(
          "Source state must be provided before reseting the source position");
    }
    sourcePosition = null;
  }

  void resetDestinationPosition() {
    if (destinationState == null) {
      throw Exception(
          "Destination state must be provided before reseting the destination position");
    }
    destinationPosition = null;
  }

  void updateIsCurved(bool value) {
    /*Call this before detach the transition with false value*/
    /*Call this after attach the transition with true value*/
    if (sourceStateId == null || destinationStateId == null) {
      return;
    }
    try {
      TransitionType transition = DiagramList()
          .getTransitionByState(destinationStateId!, sourceStateId!)!;
      transition.isCurved = value;
      isCurved = value;
    } catch (e) {
      return;
    }
  }

  @override
  double get top {
    double min1 = min(startButtonPosition.dy, endButtonPosition.dy);
    double min2 = min(min1, controlPoint.dy);
    return isCurved ? min2 : min1;
  }

  @override
  double get left {
    double min1 = min(startButtonPosition.dx, endButtonPosition.dx);
    double min2 = min(min1, controlPoint.dx);
    return isCurved ? min2 : min1;
  }

  @override
  double get bottom {
    double max1 = max(startButtonPosition.dy, endButtonPosition.dy);
    double max2 = max(max1, controlPoint.dy);
    return isCurved ? max2 : max1;
  }

  @override
  double get right {
    double max1 = max(startButtonPosition.dx, endButtonPosition.dx);
    double max2 = max(max1, controlPoint.dx);
    return isCurved ? max2 : max1;
  }

  @override
  String toString() {
    return {
      'id': id,
      'label': label,
      'sourceState': sourceState,
      'destinationState': destinationState,
      'sourcePosition': sourcePosition,
      'destinationPosition': destinationPosition,
    }.toString();
  }

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
      hasFocus.hashCode ^
      sourceStateId.hashCode ^
      destinationStateId.hashCode ^
      sourcePosition.hashCode ^
      destinationPosition.hashCode ^
      isCurved.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // Check for identical references
    if (other is TransitionType) {
      return other.id == id &&
          other.label == label &&
          other.hasFocus == hasFocus &&
          other.sourceStateId == sourceStateId &&
          other.destinationStateId == destinationStateId &&
          other.sourcePosition == sourcePosition &&
          other.destinationPosition == destinationPosition &&
          other.isCurved == isCurved;
    }
    return false;
  }
}
