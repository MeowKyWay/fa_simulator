import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/transition/transition_gesture_detector.dart';
import 'package:fa_simulator/widget/diagram/transition/transition_pivot.dart';
import 'package:fa_simulator/widget/painter/transition/arrow_head_painter.dart';
import 'package:fa_simulator/widget/painter/transition/dash_line_painter.dart';
import 'package:fa_simulator/widget/painter/transition/staight_line_painter.dart';
import 'package:flutter/material.dart';

class DiagramTransition {
  final TransitionType transition;

  const DiagramTransition({
    required this.transition,
  });

  List<Widget> build() {
    double angle =
        (transition.startPosition - transition.endPosition).direction;

    double offsetLength = stateSize / 2;

    return [
      TransitionGestureDetector(transition: transition),
      CustomPaint(
        painter: ArrowHeadPainter(
          position: transition.endPosition,
          angle: angle,
          arrowSize: 10,
          offset:
              transition.destinationStateCentered ?? false ? offsetLength : 0,
        ),
        child: Container(),
      ),
      CustomPaint(
        painter: StaightLinePainter(
          start: transition.startPosition,
          end: transition.endPosition,
          startOffset:
              transition.sourceStateCentered ?? false ? stateSize / 2 : 0,
          endOffset:
              transition.destinationStateCentered ?? false ? stateSize / 2 : 0,
        ),
        child: Container(),
      ),
      transition.hasFocus
          ? CustomPaint(
              painter: DashLinePainter(
                start: transition.startPosition,
                end: transition.endPosition,
                startOffset:
                    transition.sourceStateCentered ?? false ? stateSize / 2 : 0,
                endOffset: transition.destinationStateCentered ?? false
                    ? stateSize / 2
                    : 0,
              ),
              child: Container(),
            )
          : Container(),
      ...TransitionPivot(transition: transition).build(),
    ];
  }
}
