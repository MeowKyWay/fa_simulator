import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/transition/attach_transitions_action.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/dragging_provider.dart';
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
    return DragTarget(
      onWillAcceptWithDetails: (details) {
        if (details.data is NewTransitionType) {
          return _onWillAcceptNewTransitionWithDetails(
              details.data as NewTransitionType);
        }
        if (details.data is DraggingTransitionType) {
          return _onWillAcceptDraggingTransition(
              details.data as DraggingTransitionType);
        }
        return false;
      },
      onAcceptWithDetails: (details) {
        if (details.data is NewTransitionType) {
          _onAcceptNewTransitionWithDetails(details.data as NewTransitionType);
        }
        if (details.data is DraggingTransitionType) {
          _onAcceptDraggingTransition(details.data as DraggingTransitionType);
        }
      },
      onLeave: _onLeave,
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => child,
    );
  }

  bool _onWillAcceptNewTransitionWithDetails(NewTransitionType data) {
    //TODO handle self loop transition
    if (data.from.id == state.id) {
      return false;
    }
    NewTransitionProvider().destinationState = state;
    return true;
  }

  bool _onWillAcceptDraggingTransition(DraggingTransitionType data) {
    //TODO handle self loop transition
    if (data.draggingPivot == TransitionPivotType.center) {
      return false;
    }
    DraggingProvider().hoveringStateId = state.id;
    return true;
  }

  void _onAcceptNewTransitionWithDetails(NewTransitionType data) {
    StateType sourceState = data.from;

    AppActionDispatcher().execute(
      CreateTransitionAction(
        sourceStateId: sourceState.id,
        destinationStateId: state.id,
      ),
    );
  }

  void _onAcceptDraggingTransition(DraggingTransitionType data) {
    log("StateDragTarget._onAcceptDraggingTransition()");
    TransitionEndPointType endPoint =
        data.draggingPivot == TransitionPivotType.start
            ? TransitionEndPointType.start
            : TransitionEndPointType.end;
    AppActionDispatcher().execute(AttachTransitionAction(
      id: data.transition.id,
      endPoint: endPoint,
      stateId: state.id,
      isCentered: true,
    ));
  }

  void _onLeave(details) {
    if (!NewTransitionProvider().destinationStateFlag) {
      NewTransitionProvider().destinationState = null;
    }
    if (DraggingProvider().hoveringStateId == state.id) {
      DraggingProvider().hoveringStateId = null;
    }
  }
}
