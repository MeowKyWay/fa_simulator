import 'dart:developer';

import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';

class StateHoverOverlayDragTarget extends StatelessWidget {
  final Widget child;
  final StateType state;

  const StateHoverOverlayDragTarget({
    super.key,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAcceptWithDetails: (DragTargetDetails details) {
        if (details.data is NewTransitionType) {
          if ((details.data as NewTransitionType).from.id == state.id) {
            return false;
          }
          return true;
        }
        return false;
      },
      onAcceptWithDetails: (details) {
        StateType state = (details.data as NewTransitionType).from;

        log('State ${state.id} accepted by ${state.id}');
        log('source angle: ${NewTransitionProvider().sourceStateAngle} destination angle: ${NewTransitionProvider().destinationStateAngle}');
      },
      onLeave: (details) {},
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => child,
    );
  }
}
