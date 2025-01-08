import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/painter/transition_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyNewTransitionFeedback extends StatelessWidget {
  const BodyNewTransitionFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTransitionProvider>(builder: (context, provider, child) {
      if (!provider.isDraggingNewTransition) {
        return Container();
      }
      if (provider.draggingPosition == null) {
        throw Exception(
            'isDraggingNewTransition is true but draggingPosition is null');
      }
      return Positioned.fill(
        child: IgnorePointer(
          child: CustomPaint(
            painter: TransitionPainter(
              start: provider.sourceStatePosition!,
              end: provider.destinationStatePosition ?? provider.draggingPosition!,
              sourceOffset: stateSize / 2,
              destinationOffset:
                  provider.destinationStatePosition != null ? stateSize / 2 : 0,
              color: Theme.of(context).colorScheme.outline,
            ),
            child: Container(),
          ),
        ),
      );
    });
  }
}
