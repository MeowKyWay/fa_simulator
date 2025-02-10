import 'package:fa_simulator/widget/diagram/transition/transition_node.dart';
import 'package:fa_simulator/widget/sidebar/palette/transition/transition_palette.dart';
import 'package:flutter/material.dart';

class TransitionWrap extends StatelessWidget {
  final double size = 50;

  const TransitionWrap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Calculate spacing based on available width
      double availableWidth = constraints.maxWidth;
      double chipWidth = 50; // Approximate width of each chip
      int itemsPerRow = (availableWidth / chipWidth).floor();
      double spacing =
          (availableWidth - itemsPerRow * chipWidth) / (itemsPerRow - 1);
      return Wrap(
        spacing: spacing > 0 ? spacing : 8.0,
        runSpacing: 8.0,
        children: [
          TransitionPalette(
            data: TransitionPaletteDragData(),
            size: size,
            feedback: transition(context: context),
            child: transition(context: context, transitionSize: size),
          ),
          TransitionPalette(
            data: TransitionPaletteDragData(
              isEpsilon: true,
            ),
            size: size,
            feedback: transition(context: context),
            child: transition(
                context: context, transitionSize: size, isEpsilon: true),
          ),
        ],
      );
    });
  }
}
