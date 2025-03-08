import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/change_state_type_action.dart';
import 'package:fa_simulator/action/transition/attach_transitions_action.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/sidebar/palette/state/state_palette.dart';
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
        if (details.data is StatePaletteDragData) {
          return _onWillAcceptStatePaletteDragData(
              details.data as StatePaletteDragData);
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
        if (details.data is StatePaletteDragData) {
          _onAcceptPaletteDragData(details.data as StatePaletteDragData);
        }
      },
      onLeave: _onLeave,
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => child,
    );
  }

  bool _onWillAcceptNewTransitionWithDetails(NewTransitionType data) {
    NewTransitionProvider().destinationState = state;
    return true;
  }

  bool _onWillAcceptDraggingTransition(DraggingTransitionType data) {
    TransitionDraggingProvider().hoveringStateId = state.id;
    return true;
  }

  bool _onWillAcceptStatePaletteDragData(StatePaletteDragData data) {
    //TODO preview the state change it type
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
    if (data.draggingPivot == TransitionPivotType.loop) {
      return;
    }
    final sourceStateId = data.draggingPivot == TransitionPivotType.start
        ? state.id
        : data.transition.sourceStateId;
    final destinationStateId = data.draggingPivot == TransitionPivotType.end
        ? state.id
        : data.transition.destinationStateId;
    if (DiagramList()
        .transitionOfStateIsExist(sourceStateId, destinationStateId)) {
      return;
    }
    TransitionEndPointType endPoint = data.draggingPivot.endPointType;
    try {
      AppActionDispatcher().execute(AttachTransitionAction(
        id: data.transition.id,
        endPoint: endPoint,
        stateId: state.id,
        isCentered: true,
      ));
    } catch (e) {
      log(e.toString());
    }
  }

  void _onAcceptPaletteDragData(StatePaletteDragData data) {
    AppActionDispatcher().execute(
      ChangeStateTypeAction(
        id: state.id,
        isInitial: data.isInitial ? true : null,
        isFinal: data.isFinal ? true : null,
      ),
    );
  }

  void _onLeave(details) {
    if (!NewTransitionProvider().destinationStateFlag) {
      NewTransitionProvider().destinationState = null;
    }
    if (TransitionDraggingProvider().hoveringStateId == state.id) {
      TransitionDraggingProvider().hoveringStateId = null;
    }
  }
}
