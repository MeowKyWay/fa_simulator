import 'dart:collection';
import 'dart:math';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class TransitionType extends DiagramType<TransitionType> {
  String? sourceStateId;
  String? destinationStateId;

  Offset? sourcePosition;
  Offset? destinationPosition;

  double loopAngle;

  bool isCurved;

  final double _offset = 10;
  final double _loopRadius = stateSize / 3;

  TransitionType({
    required super.id,
    required super.label,
    super.hasFocus,
    this.sourceStateId,
    this.destinationStateId,
    this.sourcePosition,
    this.destinationPosition,
    this.loopAngle = -pi / 2,
    this.isCurved = false,
  }) {
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

  @override
  set label(String value) {
    String t = value.replaceAll(RegExp(r"^,+|,+$"), "");
    SplayTreeSet<String> symbols = SplayTreeSet<String>();
    for (String symbol in t.split(',')) {
      if (symbol.isEmpty) {
        continue;
      }
      symbols.add(symbol.trim());
    }
    super.label = symbols.join(',');
  }

  SplayTreeSet<String> get symbols {
    SplayTreeSet<String> symbols = SplayTreeSet<String>();
    symbols.addAll(label.split(','));
    return symbols;
  }

  void removeSymbol(String symbol) {
    label = label.replaceAll(symbol, '');
    label = label.replaceAll(',,', ',');
    label = label.replaceAll(RegExp(r'^,'), '');
    label = label.replaceAll(RegExp(r',$'), '');
    label = label.trim();
  }

  Path getHitBox(double offset) {
    Offset start = startButtonPosition - Offset(left - 5, top - 5);
    Offset end = endButtonPosition - Offset(left - 5, top - 5);

    Offset point1 = calculateNewPoint(start, offset, startAngle + pi / 2);
    Offset point2 = calculateNewPoint(end, offset, startAngle + pi / 2);

    Offset point3 = calculateNewPoint(start, offset, startAngle - pi / 2);
    Offset point4 = calculateNewPoint(end, offset, startAngle - pi / 2);

    if (loopCenter != null) {
      double radius1 = _loopRadius + offset;
      double radius2 = _loopRadius - offset;
      Offset center = loopCenter! - Offset(left - 5, top - 5);
      Rect rect1 = Rect.fromCircle(center: center, radius: radius1);
      Rect rect2 = Rect.fromCircle(center: center, radius: radius2);
      Offset p1 = calculateNewPoint(center, radius1, endLineAngle + pi);
      Offset p2 = calculateNewPoint(
          center, radius2, -endLineAngle + pi + 2 * loopAngle);
      Path path = Path();
      path.addArc(
          rect1, endLineAngle + pi, 2 * pi - (endLineAngle - loopAngle) * 2);
      path.lineTo(p2.dx, p2.dy);
      path.arcTo(rect2, -endLineAngle + pi - 2 * loopAngle,
          -(2 * pi - (endLineAngle - loopAngle) * 2), false);
      path.lineTo(p1.dx, p1.dy);
      path.close();
      return path;
    }

    if (isCurved && sourceState != null && destinationState != null) {
      // Calculate the center of the control points
      Offset controlPoint = this.controlPoint - Offset(left - 5, top - 5);
      Offset controlPoint1 =
          calculateNewPoint(controlPoint, offset, startAngle + pi / 2);
      Offset controlPoint2 =
          calculateNewPoint(controlPoint, offset, startAngle - pi / 2);

      Path path = Path();
      path.moveTo(point1.dx, point1.dy);
      path.quadraticBezierTo(
          controlPoint1.dx, controlPoint1.dy, point2.dx, point2.dy);
      path.lineTo(point4.dx, point4.dy);
      path.quadraticBezierTo(
          controlPoint2.dx, controlPoint2.dy, point3.dx, point3.dy);
      path.lineTo(point1.dx, point1.dy);
      path.close();
      return path;
    }

    Path path = Path();
    path.moveTo(point1.dx, point1.dy);
    path.lineTo(point2.dx, point2.dy);
    path.lineTo(point4.dx, point4.dy);
    path.lineTo(point3.dx, point3.dy);
    path.lineTo(point1.dx, point1.dy);
    path.close();
    return path;
  }

  Path get path {
    Offset start = startButtonPosition;
    Offset end = endButtonPosition;
    if (loopCenter != null) {
      double radius = _loopRadius;
      Offset center = loopCenter!;
      Path path = Path();
      Rect rect = Rect.fromCircle(center: center, radius: radius);
      path.addArc(
          rect, endLineAngle + pi, 2 * pi - (endLineAngle - loopAngle) * 2);
      return path;
    }
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

  Offset? get loopCenter {
    if (sourceStateId == destinationStateId && sourceState != null) {
      double radius = _loopRadius;
      return calculateNewPoint(
          sourceState!.position, stateSize / 2 + radius - _offset, loopAngle);
    }
    return null;
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

  Offset get centerPosition {
    if (loopCenter != null) {
      return calculateNewPoint(loopCenter!, _loopRadius, loopAngle);
    }
    if (isCurved && sourceState != null && destinationState != null) {
      return controlPoint;
    }
    return (startButtonPosition + endButtonPosition) / 2;
  }

  Offset get startButtonPosition {
    if (sourcePosition != null) {
      return sourcePosition!;
    }
    if (loopCenter != null) {
      return calculateNewPoint(
        sourceState!.position,
        stateSize / 2,
        -startLineAngle + 2 * loopAngle,
      );
    }
    if (isCurved) {
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
    if (loopCenter != null) {
      return calculateNewPoint(
        destinationState!.position,
        stateSize / 2,
        startLineAngle,
      );
    }
    if (isCurved) {
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

  double get startLineAngle {
    if (loopCenter != null) {
      double ra = stateSize / 2;
      double rb = _loopRadius;
      double d = ra + rb - _offset;
      return acos((pow(ra, 2) - pow(rb, 2) + pow(d, 2)) / (2 * ra * d)) +
          loopAngle;
    }
    if (!isCurved) {
      return startAngle + pi;
    }

    // Calculate the tangent vector at the start of the curve (t = 0)
    double dx = controlPoint.dx - startButtonPosition.dx;
    double dy = controlPoint.dy - startButtonPosition.dy;

    // Calculate the angle using atan2 (returns the angle in radians)
    return atan2(dy, dx);
  }

  double get endLineAngle {
    if (loopCenter != null) {
      double ra = _loopRadius;
      double rb = stateSize / 2;
      double d = ra + rb - _offset;
      return acos((pow(ra, 2) - pow(rb, 2) + pow(d, 2)) / (2 * ra * d)) +
          loopAngle;
    }
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

  bool isComplete() {
    return sourceStateId != null && destinationStateId != null;
  }

  @override
  double get top {
    if (loopCenter != null) {
      return loopCenter!.dy - _loopRadius;
    }
    double min1 = min(startButtonPosition.dy, endButtonPosition.dy);
    double min2 = min(min1, controlPoint.dy);
    return isCurved ? min2 : min1;
  }

  @override
  double get left {
    if (loopCenter != null) {
      return loopCenter!.dx - _loopRadius;
    }
    double min1 = min(startButtonPosition.dx, endButtonPosition.dx);
    double min2 = min(min1, controlPoint.dx);
    return isCurved ? min2 : min1;
  }

  @override
  double get bottom {
    if (loopCenter != null) {
      return loopCenter!.dy + _loopRadius;
    }
    double max1 = max(startButtonPosition.dy, endButtonPosition.dy);
    double max2 = max(max1, controlPoint.dy);
    return isCurved ? max2 : max1;
  }

  @override
  double get right {
    if (loopCenter != null) {
      return loopCenter!.dx + _loopRadius;
    }
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
      sourceStateId.hashCode ^
      destinationStateId.hashCode ^
      sourcePosition.hashCode ^
      destinationPosition.hashCode ^
      loopAngle.hashCode ^
      isCurved.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // Check for identical references
    if (other is TransitionType) {
      return other.id == id &&
          other.label == label &&
          other.sourceStateId == sourceStateId &&
          other.destinationStateId == destinationStateId &&
          other.sourcePosition == sourcePosition &&
          other.destinationPosition == destinationPosition &&
          loopAngle == other.loopAngle &&
          other.isCurved == isCurved;
    }
    return false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'transition',
      'id': id,
      'label': label,
      'sourceStateId': sourceStateId,
      'destinationStateId': destinationStateId,
      'sourcePosition': sourcePosition == null
          ? null
          : {
              'dx': sourcePosition?.dx,
              'dy': sourcePosition?.dy,
            },
      'destinationPosition': destinationPosition == null
          ? null
          : {
              'dx': destinationPosition?.dx,
              'dy': destinationPosition?.dy,
            },
      'loopAngle': loopAngle,
      'isCurved': isCurved,
    };
  }

  factory TransitionType.fromJson(Map<String, dynamic> json) {
    return TransitionType(
      id: json['id'],
      label: json['label'],
      sourceStateId: json['sourceStateId'],
      destinationStateId: json['destinationStateId'],
      sourcePosition: json['sourcePosition'] == null
          ? null
          : Offset(
              json['sourcePosition']['dx'],
              json['sourcePosition']['dy'],
            ),
      destinationPosition: json['destinationPosition'] == null
          ? null
          : Offset(
              json['destinationPosition']['dx'],
              json['destinationPosition']['dy'],
            ),
      loopAngle: json['loopAngle'],
      isCurved: json['isCurved'],
    );
  }

  @override
  TransitionType copyWith() {
    return TransitionType(
      id: id,
      label: label,
      sourceStateId: sourceStateId,
      destinationStateId: destinationStateId,
      sourcePosition: sourcePosition,
      destinationPosition: destinationPosition,
      loopAngle: loopAngle,
      isCurved: isCurved,
    );
  }
}

int transitionComparator(TransitionType a, TransitionType b) {
  // Get sourceStateLabels
  String? sourceA = a.sourceState?.label;
  String? sourceB = b.sourceState?.label;

  // Compare sourceStateLabels, null values go to the back
  if (sourceA == null && sourceB == null) {
    // Both are null, they are equal
    return 0;
  } else if (sourceA == null) {
    // a is null, sort it to the back
    return 1;
  } else if (sourceB == null) {
    // b is null, sort it to the back
    return -1;
  }

  int sourceComparison = sourceA.compareTo(sourceB);
  if (sourceComparison != 0) {
    return sourceComparison;
  }

  // If sourceStateLabels are equal, compare destinationStateLabels
  String? destA = a.destinationState?.label;
  String? destB = b.destinationState?.label;

  // Compare destinationStateLabels, null values go to the back
  if (destA == null && destB == null) {
    // Both are null, they are equal
    return 0;
  } else if (destA == null) {
    // a is null, sort it to the back
    return 1;
  } else if (destB == null) {
    // b is null, sort it to the back
    return -1;
  }

  return destA.compareTo(destB);
}
