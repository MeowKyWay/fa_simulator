import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/painter/transition_painter.dart';
import 'package:flutter/material.dart';

class DiagramTransition extends StatelessWidget {
  final TransitionType transition;

  const DiagramTransition({
    super.key,
    required this.transition,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TransitionPainter(
        start: transition.startPosition,
        end: transition.endPosition,
        sourceOffset:
            transition.sourceStateCentered ?? false ? stateSize / 2 : 0,
        destinationOffset:
            transition.destinationStateCentered ?? false ? stateSize / 2 : 0,
      ),
    );
  }
}
