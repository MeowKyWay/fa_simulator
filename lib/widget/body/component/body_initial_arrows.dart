import 'package:fa_simulator/widget/body/initial_arrow/initial_arrow.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyInitialArrows extends StatelessWidget {
  const BodyInitialArrows({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(
      builder: (context, diagramList, child) {
        return Positioned.fill(
          child: IgnorePointer(
            // To prevent the transition from absorbing drag events
            ignoring: DiagramDraggingProvider().isDragging ||
                NewTransitionProvider().isDraggingNewTransition ||
                TransitionDraggingProvider().isDragging,
            child: Stack(
              children: diagramList.startStates.expand((state) {
                return StartArrow(state: state).build(context);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
