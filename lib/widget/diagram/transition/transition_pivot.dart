import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/transition/transition_pivot_button.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class TransitionPivot {
  final TransitionType transition;

  const TransitionPivot({
    required this.transition,
  });

  List<Widget> build() {
    double offset = 5;

    Offset startPivotPosition = calculateNewPoint(
      transition.startPosition,
      (transition.sourceStateCentered ?? false ? stateSize / 2 : 0) + offset,
      transition.startAngle + pi,
    );
    Offset endPivotPosition = calculateNewPoint(
      transition.endPosition,
      (transition.destinationStateCentered ?? false ? stateSize / 2 : 0) + offset,
      transition.endAngle + pi,
    );
    Offset centerPivotPosition =
        transition.centerPivot ?? (startPivotPosition + endPivotPosition) / 2;

    return [
      TransitionPivotButton(
        position: transition.centerPivot ?? centerPivotPosition,
      ),
      TransitionPivotButton(
        position: startPivotPosition,
      ),
      TransitionPivotButton(
        position: endPivotPosition,
      ),
    ];
  }
}
