import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/diagram/transition/transition_gesture_detector.dart';
import 'package:fa_simulator/widget/diagram/transition/transition_label.dart';
import 'package:fa_simulator/widget/diagram/transition/transition_pivot.dart';
import 'package:fa_simulator/widget/painter/transition/arrow_head_painter.dart';
import 'package:fa_simulator/widget/painter/transition/dash_line_painter.dart';
import 'package:fa_simulator/widget/painter/transition/transition_line_painter.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';

class DiagramTransition {
  final TransitionType transition;
  final BuildContext context;

  const DiagramTransition({
    required this.transition,
    required this.context,
  });

  List<Widget> build() {
    return [
      TransitionGestureDetector(transition: transition),
      CustomPaint(
        painter: ArrowHeadPainter(
          position: transition.endButtonPosition,
          angle: transition.endLineAngle,
          arrowSize: 10,
          color: Theme.of(context).colorScheme.outline,
        ),
        child: Container(),
      ),
      Stack(
        children: [
          CustomPaint(
            painter: TransitionLinePainter(
              transition: transition,
              color: Theme.of(context).colorScheme.outline,
            ),
            child: Container(),
          ),
          FocusProvider().hasFocus(transition.id)
              ? CustomPaint(
                  painter: DashLinePainter(
                    transition: transition,
                    color: Theme.of(context).focusColor,
                  ),
                  child: Container(),
                )
              : Container(),
        ],
      ),
      ...TransitionPivot(transition: transition).build(),
      TransitionLabel(
        transition: transition,
        isRenaming: RenamingProvider().renamingItemId == transition.id,
      ),
    ];
  }
}
