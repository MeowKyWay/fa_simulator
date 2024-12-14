import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
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

    double startOffset = transition.sourceStateId != null ? offset : 0;
    double endOffset = transition.destinationStateId != null ? offset : 0;

    startOffset = transition.sourceStateId == transition.destinationStateId ? 0 : startOffset;
    endOffset = transition.sourceStateId == transition.destinationStateId ? 0 : endOffset;

    Offset startPivotPosition = calculateNewPoint(
      transition.startButtonPosition,
      startOffset,
      transition.startLineAngle,
    );
    Offset endPivotPosition = calculateNewPoint(
      transition.endButtonPosition,
      endOffset,
      transition.endLineAngle,
    );

    return [
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
