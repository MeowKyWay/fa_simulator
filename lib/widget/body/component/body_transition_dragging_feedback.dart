import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/painter/transition/dash_line_painter.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyTransitionDraggingFeedback extends StatelessWidget {
  const BodyTransitionDraggingFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TransitionDraggingProvider>(builder: (context, provider, child) {
      if (provider.draggingItemId == null) {
        return Container();
      }
      TransitionType transition;
      try {
        transition = DiagramList().transition(provider.draggingItemId!)!;
      } catch (e) {
        provider.reset();
        return Container();
      }

      Offset start = transition.startButtonPosition;
      Offset end = transition.endButtonPosition;

      StateType? hoveringState;
      if (provider.hoveringStateId != null) {
        try {
          hoveringState = DiagramList().state(provider.hoveringStateId!);
        } catch (e) {
          hoveringState = null;
        }
      }

      switch (provider.pivotType) {
        case TransitionPivotType.start:
          start = provider.endPosition!;
          if (hoveringState != null) {
            start = hoveringState.position;
          }
          if (transition.destinationState != null) {
            Offset desPos = transition.destinationState!.position;
            end = calculateNewPoint(
                desPos, stateSize / 2, (start - desPos).direction);
          }
          if (hoveringState != null) {
            start = calculateNewPoint(start, stateSize/2, (end - start).direction);
          }
          break;
        case TransitionPivotType.end:
          end = provider.endPosition!;
          if (hoveringState != null) {
            end = hoveringState.position;
          }
          if (transition.sourceState != null) {
            Offset srcPos = transition.sourceState!.position;
            start = calculateNewPoint(
                srcPos, stateSize / 2, (end - srcPos).direction);
          }
          if (hoveringState != null) {
            end = calculateNewPoint(end, stateSize/2, (start - end).direction);
          }
          break;
        default:
          break;
      }

      return CustomPaint(
          painter: DashLinePainter(start: start, end: end, color: Theme.of(context).focusColor),);
    });
  }
}
