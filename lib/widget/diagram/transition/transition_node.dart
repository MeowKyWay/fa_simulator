import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/resource/diagram_character.dart';
import 'package:fa_simulator/widget/painter/line_painter.dart';
import 'package:fa_simulator/widget/painter/transition/arrow_head_painter.dart';
import 'package:flutter/material.dart';

Widget transition({
  double transitionSize = stateSize,
  bool isEpsilon = false,
  required BuildContext context,
}) {
  ThemeData theme = Theme.of(context);
  return SizedBox(
    height: transitionSize,
    width: transitionSize,
    child: Stack(
      children: [
        CustomPaint(
          painter: LinePainter(
            color: theme.colorScheme.outline,
            strokeWidth: 1,
            start: Offset(0, transitionSize),
            end: Offset(transitionSize, 0),
          ),
          child: Container(
            color: Colors.transparent,
          ),
        ),
        CustomPaint(
          painter: ArrowHeadPainter(
            color: theme.colorScheme.outline,
            angle: 3 * pi / 4,
            position: Offset(transitionSize, 0),
          ),
          child: Container(
            color: Colors.transparent,
          ),
        ),
        if (isEpsilon)
          Center(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                DiagramCharacter.epsilon,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          )
      ],
    ),
  );
}
