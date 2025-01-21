import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/body/initial_arrow/initial_arrow_button.dart';
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
              state.position, stateSize / 2, state.initialArrowAngle),
          angle: state.initialArrowAngle,
          arrowSize: 10,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      CustomPaint(
        painter: LinePainter(
          start: calculateNewPoint(
            state.position,
            stateSize / 2,
            state.initialArrowAngle,
          ),
          end: calculateNewPoint(
            state.position,
            stateSize / 2 + startArrowLength,
            state.initialArrowAngle,
          ),
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      StartArrowButton(state: state),
    ];
  }
}
