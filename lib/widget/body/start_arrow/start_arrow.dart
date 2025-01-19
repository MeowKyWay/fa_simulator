import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/body/start_arrow/start_arrow_button.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/painter/line_painter.dart';
import 'package:fa_simulator/widget/painter/transition/arrow_head_painter.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class StartArrow {
  final StateType state;

  const StartArrow({
    required this.state,
  });

  List<Widget> build(BuildContext context) {
    return [
      CustomPaint(
        painter: ArrowHeadPainter(
          position: calculateNewPoint(
              state.position, stateSize / 2, state.startArrowAngle),
          angle: state.startArrowAngle,
          arrowSize: 10,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      CustomPaint(
        painter: LinePainter(
          start: calculateNewPoint(
            state.position,
            stateSize / 2,
            state.startArrowAngle,
          ),
          end: calculateNewPoint(
            state.position,
            stateSize / 2 + startArrowLength,
            state.startArrowAngle,
          ),
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      StartArrowButton(state: state),
    ];
  }
}
