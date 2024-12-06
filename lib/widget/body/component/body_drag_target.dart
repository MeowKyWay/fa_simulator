
import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';

class DraggingDiagramType {}

class DraggingStateType extends DraggingDiagramType {
  final StateType state;

  DraggingStateType({
    required this.state,
  });
}

enum TransitionEnd { source, destination }

class DraggingTransitionType extends DraggingDiagramType {
  final TransitionType transition;
  TransitionEnd draggingEnd;

  DraggingTransitionType({
    required this.transition,
    required this.draggingEnd,
  });
}

class BodyDragTarget extends StatelessWidget {
  const BodyDragTarget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Object>(
      onWillAcceptWithDetails: (details) {
        if (details.data is DraggingStateType) {
          return _onWillAcceptDraggingState(details.data as DraggingStateType);
        } else if (details.data is DraggingTransitionType) {
          return _onWillAcceptDraggingTransition(
              details.data as DraggingTransitionType);
        } else if (details.data is NewTransitionType) {
          return _onWillAcceptNewTransition(details.data as NewTransitionType);
        }
        return false;
      },
      onAcceptWithDetails: (details) {
        if (details.data is DraggingStateType) {
          _onAcceptDraggingState(details.data as DraggingStateType);
        } else if (details.data is DraggingTransitionType) {
          _onAcceptDraggingTransition(details.data as DraggingTransitionType);
        } else if (details.data is NewTransitionType) {
          _onAcceptNewTransition(details.data as NewTransitionType);
        }
      },
      onMove: (details) {},
      onLeave: (details) {},
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => Container(),
    );
  }

  bool _onWillAcceptDraggingState(DraggingStateType draggingState) {
    return true;
  }

  bool _onWillAcceptDraggingTransition(
      DraggingTransitionType draggingTransition) {
    return true;
  }

  bool _onWillAcceptNewTransition(NewTransitionType newTransition) {
    return true;
  }

  void _onAcceptDraggingState(DraggingStateType draggingState) {}

  void _onAcceptDraggingTransition(DraggingTransitionType draggingTransition) {}

  void _onAcceptNewTransition(NewTransitionType newTransition) {
    AppActionDispatcher().execute(
      CreateTransitionAction(
        sourceState: newTransition.from,
        sourceStateCentered: NewTransitionProvider().sourceStateCentered,
        sourceStateAngle: NewTransitionProvider().sourceStateAngle,
        destinationPosition: NewTransitionProvider().draggingPosition,
      ),
    );
  }
}
