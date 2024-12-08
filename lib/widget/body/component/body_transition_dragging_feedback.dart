import 'dart:developer';

import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:fa_simulator/widget/painter/transition/dash_line_painter.dart';
import 'package:fa_simulator/widget/provider/dragging_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyTransitionDraggingFeedback extends StatelessWidget {
  const BodyTransitionDraggingFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DraggingProvider>(builder: (context, provider, child) {
      if (provider.draggingItemId == null) {
        return Container();
      }
      TransitionType transition;
      try {
        transition = DiagramList().transition(provider.draggingItemId!);
      } catch (e) {
        provider.reset();
        return Container();
      }

      Offset start = transition.startButtonPosition;
      Offset? center = transition.centerPivot;
      Offset end = transition.endButtonPosition;

      log(provider.endPosition.toString());

      switch (provider.pivotType) {
        case TransitionPivotType.start:
          start = provider.endPosition!;
          break;
        case TransitionPivotType.center:
          center = provider.endPosition!;
          break;
        case TransitionPivotType.end:
          end = provider.endPosition!;
          break;
        default:
          break;

      }

      return CustomPaint(
        painter: DashLinePainter(start: start, center: center, end: end)
      );
    });
  }
}
