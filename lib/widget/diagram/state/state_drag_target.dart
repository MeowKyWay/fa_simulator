import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';

class StateDragTarget extends StatelessWidget {
  final StateType state;
  final Widget child;

  const StateDragTarget({
    super.key,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<NewTransitionType>(
      onWillAcceptWithDetails: _onWillAcceptWithDetails,
      onAcceptWithDetails: _onAcceptWithDetails,
      onLeave: _onLeave,
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => child,
    );
  }

  bool _onWillAcceptWithDetails(DragTargetDetails<NewTransitionType> details) {
    if (details.data.from.id == state.id) {
      return false;
    }
    NewTransitionProvider().destinationState = state;
    NewTransitionProvider().destinationStateCentered = true;
    return true;
  }

  void _onAcceptWithDetails(DragTargetDetails<NewTransitionType> details) {
    StateType sourceState = details.data.from;

    AppActionDispatcher().execute(
      CreateTransitionAction(
        sourceState: sourceState,
        destinationState: state,
        sourceStateCentered: NewTransitionProvider().sourceStateCentered,
        sourceStateAngle: NewTransitionProvider().sourceStateAngle,
        destinationStateCentered: true,
        destinationStateAngle: NewTransitionProvider().destinationStateAngle,
      ),
    );
  }

  void _onLeave(details) {
    if (!NewTransitionProvider().destinationStateFlag) {
      NewTransitionProvider().destinationState = null;
    }
    NewTransitionProvider().destinationStateCentered = null;
  }
}
