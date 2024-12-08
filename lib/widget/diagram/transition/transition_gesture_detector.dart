import 'dart:developer' as developer;
import 'dart:math';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/widget/clip/transition/staight_line_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:flutter/material.dart';

class TransitionGestureDetector extends StatelessWidget {
  final TransitionType transition;

  final bool _showTransitionHitBox = false;
  final double transitionHitBoxWidth = 10;

  const TransitionGestureDetector({
    super.key,
    required this.transition,
  });

  @override
  Widget build(BuildContext context) {
    Offset tl = topLeft;
    Offset br = bottomRight;

    Offset start = transition.startButtonPosition - tl;
    Offset? center = transition.centerPivot != null
        ? transition.centerPivot! - tl
        : null;
    Offset end = transition.endButtonPosition - tl;

    return Positioned(
      top: tl.dy,
      left: tl.dx,
      child: ClipPath(
        clipper: StaightLineClipper(
          start: start,
          center: center,
          end: end,
          width: 10,
        ),
        child: GestureDetector(
          onTap: () {
            developer.log('Transition Tapped');
            AppActionDispatcher().execute(FocusAction(
              [transition.id],
            ));
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.precise,
            onEnter: (event) {
              developer.log('Mouse Enter');
            },
            child: Container(
              width: (br.dx - tl.dx).abs(),
              height: (br.dy - tl.dy).abs(),
              color: _showTransitionHitBox
                  ? Colors.white.withOpacity(0.5)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Offset get topLeft {
    double dx =
        min(transition.startButtonPosition.dx, transition.endButtonPosition.dx);
    if (transition.centerPivot != null) {
      dx = min(dx, transition.centerPivot!.dx);
    }
    double dy =
        min(transition.startButtonPosition.dy, transition.endButtonPosition.dy);
    if (transition.centerPivot != null) {
      dy = min(dy, transition.centerPivot!.dy);
    }
    dx -= transitionHitBoxWidth / 2;
    dy -= transitionHitBoxWidth / 2;

    return Offset(dx, dy);
  }

  Offset get bottomRight {
    double dx =
        max(transition.startButtonPosition.dx, transition.endButtonPosition.dx);
    if (transition.centerPivot != null) {
      dx = max(dx, transition.centerPivot!.dx);
    }
    double dy =
        max(transition.startButtonPosition.dy, transition.endButtonPosition.dy);
    if (transition.centerPivot != null) {
      dy = max(dy, transition.centerPivot!.dy);
    }
    dx += transitionHitBoxWidth / 2;
    dy += transitionHitBoxWidth / 2;

    return Offset(dx, dy);
  }
}
