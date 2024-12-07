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
    double angle = transition.startAngle;

    return [
      TransitionGestureDetector(transition: transition),
      CustomPaint(
        painter: ArrowHeadPainter(
          position: transition.endButtonPosition,
          angle: angle,
          arrowSize: 10,
        ),
        child: Container(),
      ),
      CustomPaint(
        painter: StaightLinePainter(
          start: transition.startButtonPosition,
          end: transition.endButtonPosition,
        ),
        child: Container(),
      ),
      transition.hasFocus
          ? CustomPaint(
              painter: DashLinePainter(
                start: transition.startButtonPosition,
                end: transition.endButtonPosition,
              ),
              child: Container(),
            )
          : Container(),
      ...TransitionPivot(transition: transition).build(),
    ];
  }
}
