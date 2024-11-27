import 'dart:developer';

import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_feedback_position_provider.dart';
import 'package:fa_simulator/widget/painter/transition_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyNewTransitionFeedback extends StatelessWidget {
  const BodyNewTransitionFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTransitionFeedbackPositionProvider>(
        builder: (context, position, child) {
      if (position.startPosition == null || position.endPosition == null) {
        return Container();
      }
      log(position.startPosition.toString() + " " + position.endPosition.toString());
      return Positioned.fill(
        child: CustomPaint(
          painter: TransitionPainter(
            start: position.startPosition!,
            end: position.endPosition!,
          ),
          child: Container(),
        ),
      );
    });
  }
}
