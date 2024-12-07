import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
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
    return DragTarget<NewTransitionType>(
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
        StateType sourceState = details.data.from;

        AppActionDispatcher().execute(
          CreateTransitionAction(
            sourceStateId: sourceState.id,
            destinationStateId: state.id,
            sourceStateCentered: NewTransitionProvider().sourceStateCentered,
            sourceStateAngle: NewTransitionProvider().sourceStateAngle,
            destinationStateCentered: false,
            destinationStateAngle:
                NewTransitionProvider().destinationStateAngle,
          ),
        );
      },
      onLeave: (details) {},
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => child,
    );
  }
}
