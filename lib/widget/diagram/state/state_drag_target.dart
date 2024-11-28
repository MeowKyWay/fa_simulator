import 'dart:developer';

import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';

class StateDragTarget extends StatelessWidget {
  final StateType state;
  final Widget child;

  StateDragTarget({
    super.key,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAcceptWithDetails: _onWillAcceptWithDetails,
      onAcceptWithDetails: _onAcceptWithDetails,
      onLeave: _onLeave,
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => child,
    );
  }

  bool _onWillAcceptWithDetails(DragTargetDetails details) {
    if (details.data is NewTransitionType) {
      if ((details.data as NewTransitionType).from.id == state.id) {
        return false;
      }
      NewTransitionProvider().destinationState = state;
      NewTransitionProvider().destinationStateCentered = true;
      return true;
    }
    return false;
  }

  void _onAcceptWithDetails(DragTargetDetails details) {
    NewTransitionProvider().reset();
    StateType state = (details.data as NewTransitionType).from;
    log('State ${state.id} accepted by ${state.id}');
  }

  void _onLeave(details) {
    if (!NewTransitionProvider().destinationStateFlag) {
      NewTransitionProvider().destinationState = null;
    }
    NewTransitionProvider().destinationStateCentered = null;
  }
}
