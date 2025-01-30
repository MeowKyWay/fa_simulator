import 'dart:collection';
import 'dart:math';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/resource/diagram_character.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_symbol.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class TransitionType extends DiagramType<TransitionType> {
  String? sourceStateId;
  String? destinationStateId;

  Offset? sourcePosition;
  Offset? destinationPosition;

  double loopAngle;

  bool isCurved;

  final double offset = 10;
  final double loopRadius = stateSize / 3;

  TransitionType({
    super.id,
    required super.label,
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
          'Either sourcePosition or sourceState must be provided');
    }

    if ((destinationPosition ?? destinationStateId) == null) {
      throw ArgumentError(
          'Either destinationPosition or destinationState must be provided');
    }
  }

  @override
  set label(String value) {
    String t = value.replaceAll(RegExp(r'^[, ]+|[, ]+$'), '');
    t = value.replaceAll(RegExp(r'\\e'), DiagramCharacter.epsilon);
    SplayTreeSet<String> symbols = SplayTreeSet<String>();
    for (String symbol in t.split(',')) {
      if (symbol.isEmpty) {
        continue;
      }
      if (symbol.contains(DiagramCharacter.epsilon)) {
        symbol = DiagramCharacter.epsilon;
      }
      symbols.add(symbol.trim());
    }
    super.label = symbols.join(',');
  }

  Offset? get loopCenter {
    if (sourceStateId == destinationStateId && sourceState != null) {
      double radius = loopRadius;
      return calculateNewPoint(
          sourceState!.position, stateSize / 2 + radius - offset, loopAngle);
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
      return calculateNewPoint(loopCenter!, loopRadius, loopAngle);
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
      double rb = loopRadius;
      double d = ra + rb - offset;
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
      double ra = loopRadius;
      double rb = stateSize / 2;
      double d = ra + rb - offset;
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
          'Source position must be provided before reseting the source state');
    }
    sourceStateId = null;
    isCurved = false;
  }

  void resetDestinationState() {
    if (destinationPosition == null) {
      throw Exception(
          'Destination position must be provided before reseting the destination state');
    }
    destinationStateId = null;
    isCurved = false;
  }

  void resetSourcePosition() {
    if (sourceState == null) {
      throw Exception(
          'Source state must be provided before reseting the source position');
    }
    sourcePosition = null;
  }

  void resetDestinationPosition() {
    if (destinationState == null) {
      throw Exception(
          'Destination state must be provided before reseting the destination position');
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
      TransitionType transition;
      transition = DiagramList().getTransitionByStates(
        destinationStateId!,
        sourceStateId!,
      );
      DiagramList().executeCommand(
        UpdateTransitionCommand(
          detail: TransitionDetail(id: transition.id, isCurved: value),
        ),
      );
      isCurved = value;
    } catch (e) {
      return;
    }
  }

  bool isComplete() {
    return sourceStateId != null &&
        destinationStateId != null &&
        symbols.isNotEmpty;
  }

  @override
  double get top {
    if (loopCenter != null) {
      return loopCenter!.dy - loopRadius;
    }
    double min1 = min(startButtonPosition.dy, endButtonPosition.dy);
    double min2 = min(min1, controlPoint.dy);
    return isCurved ? min2 : min1;
  }

  @override
  double get left {
    if (loopCenter != null) {
      return loopCenter!.dx - loopRadius;
    }
    double min1 = min(startButtonPosition.dx, endButtonPosition.dx);
    double min2 = min(min1, controlPoint.dx);
    return isCurved ? min2 : min1;
  }

  @override
  double get bottom {
    if (loopCenter != null) {
      return loopCenter!.dy + loopRadius;
    }
    double max1 = max(startButtonPosition.dy, endButtonPosition.dy);
    double max2 = max(max1, controlPoint.dy);
    return isCurved ? max2 : max1;
  }

  @override
  double get right {
    if (loopCenter != null) {
      return loopCenter!.dx + loopRadius;
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
    try {
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
    } on Exception catch (e) {
      throw FormatException('Error parsing TransitionType from JSON: $e');
    }
  }

  @override
  TransitionType get clone {
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

  @override
  int compareTo(TransitionType other) {
    return transitionComparator(this, other);
  }
}

int transitionComparator(TransitionType a, TransitionType b) {
  if (a.id == b.id) return 0;
  // Get sourceStateLabels
  String? sourceA = a.sourceState?.label;
  String? sourceB = b.sourceState?.label;

  if (sourceA == null && sourceB != null) {
    return 1;
  } else if (sourceB == null && sourceA != null) {
    return -1;
  } else if (sourceA != null && sourceB != null) {
    int result = sourceA.compareTo(sourceB);
    if (result != 0) {
      return result;
    }
  }

  // If sourceStateLabels are equal, compare destinationStateLabels
  String? destA = a.destinationState?.label;
  String? destB = b.destinationState?.label;

  if (destA == null && destB != null) {
    return 1;
  } else if (destB == null && destA != null) {
    return -1;
  } else if (destB == null) {
    int result = destA!.compareTo(destB!);
    if (result != 0) {
      return result;
    }
  }

  return a.id.compareTo(b.id);
}
