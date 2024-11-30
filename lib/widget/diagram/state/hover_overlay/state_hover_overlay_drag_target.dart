import 'dart:developer';

import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
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
        StateType sourceState = (details.data as NewTransitionType).from;

        log(NewTransitionProvider().sourceStateCentered.toString());
        addTransition(
          sourceState,
          state,
          "",
          NewTransitionProvider().sourceStateCentered,
          false,
          NewTransitionProvider().sourceStateAngle,
          NewTransitionProvider().destinationStateAngle,
        );
      },
      onLeave: (details) {},
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => child,
    );
  }
}
