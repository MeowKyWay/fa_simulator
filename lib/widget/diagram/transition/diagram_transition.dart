import 'dart:math';

import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:fa_simulator/widget/diagram/transition/transition_gesture_detector.dart';
import 'package:fa_simulator/widget/diagram/transition/transition_pivot.dart';
import 'package:fa_simulator/widget/painter/transition/arrow_head_painter.dart';
import 'package:fa_simulator/widget/painter/transition/dash_line_painter.dart';
import 'package:fa_simulator/widget/painter/transition/transition_line_painter.dart';
import 'package:flutter/material.dart';

class DiagramTransition {
  final TransitionType transition;

  const DiagramTransition({
    required this.transition,
  });

  List<Widget> build() {

    return [
      TransitionGestureDetector(transition: transition),
      CustomPaint(
        painter: ArrowHeadPainter(
          position: transition.endButtonPosition,
          angle: transition.arrowAngle,
          arrowSize: 10,
        ),
        child: Container(),
      ),
      CustomPaint(
        painter: TransitionLinePainter(
          transition: transition,
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
