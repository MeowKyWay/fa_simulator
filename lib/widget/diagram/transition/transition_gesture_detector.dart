import 'dart:developer' as developer;
import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/clip/transition/staight_line_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:flutter/material.dart';

class TransitionGestureDetector extends StatelessWidget {
  final TransitionType transition;

  const TransitionGestureDetector({
    super.key,
    required this.transition,
  });

  @override
  Widget build(BuildContext context) {
    double transitionHitBoxWidth = 10;

    double angle =
        (transition.startPosition - transition.endPosition).direction;

    double lineHeight = sin(angle + pi / 2).abs() * transitionHitBoxWidth;
    double lineWidth = cos(angle + pi / 2).abs() * transitionHitBoxWidth;

    Offset globalToLocalDelta = Offset(
      min(transition.startPosition.dx, transition.endPosition.dx) -
          lineWidth / 2,
      min(transition.startPosition.dy, transition.endPosition.dy) -
          lineHeight / 2,
    );

    Offset start = transition.startPosition - globalToLocalDelta;
    Offset end = transition.endPosition - globalToLocalDelta;

    double offsetLength = stateSize / 2;

    return Positioned(
      top: min(transition.startPosition.dy, transition.endPosition.dy) -
          lineHeight / 2,
      left: min(transition.startPosition.dx, transition.endPosition.dx) -
          lineWidth / 2,
      child: ClipPath(
        clipper: StaightLineClipper(
          start: start,
          end: end,
          startOffset:
              transition.sourceStateCentered ?? false ? offsetLength : 0,
          endOffset:
              transition.destinationStateCentered ?? false ? offsetLength : 0,
          width: 10,
        ),
        child: GestureDetector(
          onTap: () {
            developer.log('Transition: ${transition.toString()}');
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.precise,
            onEnter: (event) {
              developer.log('Mouse Enter');
            },
            child: Container(
              width: (transition.startPosition.dx - transition.endPosition.dx)
                      .abs() +
                  lineWidth,
              height: (transition.startPosition.dy - transition.endPosition.dy)
                      .abs() +
                  lineHeight,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
