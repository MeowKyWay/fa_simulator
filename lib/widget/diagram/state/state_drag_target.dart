import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/transition/attach_transitions_action.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_drag_data.dart';
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
        if (details.data is PaletteDragData) {
          return _onWillAcceptPaletteDragData(details.data as PaletteDragData);
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
        if (details.data is PaletteDragData) {
          _onAcceptPaletteDragData(details.data as PaletteDragData);
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

  bool _onWillAcceptPaletteDragData(PaletteDragData data) {
    //TODO preview the state change it type
    if (data == PaletteDragData.transition) {
      return false;
    }
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

  void _onAcceptPaletteDragData(PaletteDragData data) {
    StateTypeEnum type;
    switch (data) {
      case PaletteDragData.state:
        type = StateTypeEnum.state;
        break;
      case PaletteDragData.startState:
        type = StateTypeEnum.start;
        break;
      case PaletteDragData.acceptState:
        type = StateTypeEnum.accept;
        break;
      default:
        throw Exception("state_drag_target/_onAcceptPaletteDragData: Invalid data");
    }
    changeStateType(id: state.id, type: type);
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
