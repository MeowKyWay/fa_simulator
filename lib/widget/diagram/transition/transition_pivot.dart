import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
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
    double offset = 7.5;

    Offset startPivotPosition = calculateNewPoint(transition.startButtonPosition, offset, transition.endAngle);
    Offset endPivotPosition = calculateNewPoint(transition.endButtonPosition, offset, transition.startAngle);
    Offset centerPivotPosition = transition.centerPosition;

    return [
      TransitionPivotButton(
        position: transition.centerPivot ?? centerPivotPosition,
        hasFocus: transition.hasFocus,
        transition: transition,
        type: TransitionPivotType.center,
      ),
      TransitionPivotButton(
        position: startPivotPosition,
        hasFocus: transition.hasFocus,
        transition: transition,
        type: TransitionPivotType.start,
      ),
      TransitionPivotButton(
        position: endPivotPosition,
        hasFocus: transition.hasFocus,
        transition: transition,
        type: TransitionPivotType.end,
      ),
    ];
  }
}
