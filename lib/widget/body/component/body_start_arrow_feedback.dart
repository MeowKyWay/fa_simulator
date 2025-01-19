import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/painter/transition/arrow_head_painter.dart';
import 'package:fa_simulator/widget/painter/transition/dash_line_painter.dart';
import 'package:fa_simulator/widget/provider/start_arrow_feedback_provider.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyStartArrowFeedback extends StatelessWidget {
  const BodyStartArrowFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StartArrowFeedbackProvider>(
        builder: (context, provider, child) {
      if (provider.id == null || provider.angle == null) {
        return Container();
      }

      StateType state;
      try {
        state = DiagramList().state(provider.id)!;
      } catch (e) {
        throw Exception('body_start_arrow_feedback: State ${provider.id} not found');
      }

      return Stack(
        children: [
          CustomPaint(
            painter: ArrowHeadPainter(
              position: calculateNewPoint(
                  state.position, stateSize / 2, provider.angle!),
              angle: provider.angle!,
              arrowSize: 10,
              color: Theme.of(context).focusColor,
            ),
          ),
          CustomPaint(
            painter: DashLinePainter(
              start: calculateNewPoint(
                state.position,
                stateSize / 2,
                provider.angle!,
              ),
              end: calculateNewPoint(
                state.position,
                stateSize / 2 + startArrowLength,
                provider.angle!,
              ),
              color: Theme.of(context).focusColor,
            ),
          ),
        ],
      );
    });
  }
}
