import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/add_focus_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/config/control.dart';
import 'package:fa_simulator/widget/clip/transition/transition_hitbox_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/diagram_draggable.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:flutter/material.dart';

class TransitionGestureDetector extends StatelessWidget {
  final TransitionType transition;

  final bool _showTransitionHitBox = true;
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
    Offset end = transition.endButtonPosition - tl;

    return Positioned(
      top: tl.dy,
      left: tl.dx,
      child: ClipPath(
        clipper: TransitionHitboxClipper(
          transition: transition,
          width: 10,
        ),
        child: DiagramDraggable(
          child: Listener(
            onPointerDown: (event) {
              if (KeyboardProvider().modifierKeys.contains(multipleSelectKey)) {
                AppActionDispatcher().execute(AddFocusAction([transition.id]));
                return;
              }
              AppActionDispatcher().execute(FocusAction([transition.id]));
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.precise,
              onEnter: (event) {},
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
      ),
    );
  }

  Offset get topLeft {
    return Offset(transition.left, transition.top) -
        Offset(transitionHitBoxWidth / 2, transitionHitBoxWidth / 2);
  }

  Offset get bottomRight {
    return Offset(transition.right, transition.bottom) +
        Offset(transitionHitBoxWidth / 2, transitionHitBoxWidth / 2);
  }
}
