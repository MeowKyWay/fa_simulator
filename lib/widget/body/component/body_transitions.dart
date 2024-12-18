import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/transition/diagram_transition.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyTransitions extends StatelessWidget {
  const BodyTransitions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, diagramList, child) {
      return Positioned.fill(
        child: IgnorePointer(
          // To prevent the transition from absorbing drag events
          ignoring: DiagramDraggingProvider().isDragging ||
              NewTransitionProvider().isDraggingNewTransition ||
              TransitionDraggingProvider().isDragging,
          child: Stack(
            children: diagramList.transitions.expand((transition) {
              return DiagramTransition(transition: transition).build();
            }).toList(),
          ),
        ),
      );
    });
  }
}
