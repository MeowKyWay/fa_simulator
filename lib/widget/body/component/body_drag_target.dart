import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
import 'package:fa_simulator/action/transition/move_transitions_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';

class DraggingDiagramType {}

class DraggingStateType extends DraggingDiagramType {
  final StateType state;

  DraggingStateType({
    required this.state,
  });
}

enum TransitionPivotType {
  center,
  start,
  end,
  all,
}

enum TransitionEndPointType {
  start,
  end,
}

class DraggingTransitionType extends DraggingDiagramType {
  final TransitionType transition;
  TransitionPivotType draggingPivot;

  DraggingTransitionType({
    required this.transition,
    required this.draggingPivot,
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
        //On drag state of the entire transition move all focus state/transition
        if (details.data is DraggingDiagramType) {
          return _onWillAcceptDraggingDiagram(details.data as DraggingDiagramType);
        } 
        //On drag transition pivot move the pivot
        else if (details.data is DraggingTransitionType) {
          return _onWillAcceptDraggingTransition(
              details.data as DraggingTransitionType);
        } 
        //On drag new transition add the transition
        else if (details.data is NewTransitionType) {
          return _onWillAcceptNewTransition(details.data as NewTransitionType);
        }
        return false;
      },
      onAcceptWithDetails: (details) {
        if (details.data is DraggingStateType) {
          _onAcceptDraggingDiagram(details.data as DraggingStateType);
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

  bool _onWillAcceptDraggingDiagram(DraggingDiagramType data) {
    return true;
  }

  bool _onWillAcceptDraggingTransition(
      DraggingTransitionType data) {
    return true;
  }

  bool _onWillAcceptNewTransition(NewTransitionType data) {
    return true;
  }

  void _onAcceptDraggingDiagram(DraggingDiagramType data) {}

  void _onAcceptDraggingTransition(DraggingTransitionType data) {
    AppActionDispatcher().execute(
      MoveTransitionsAction(
        //TODO move all the focus transition
        inputs: [
          MoveTransitionActionInput(
            id: data.transition.id,
            pivotType: data.draggingPivot,
          ),
        ],
        deltaOffset: DraggingProvider().deltaOffset,
      ),
    );
  }

  void _onAcceptNewTransition(NewTransitionType data) {
    AppActionDispatcher().execute(
      CreateTransitionAction(
        sourceStateId: data.from.id,
        destinationPosition: NewTransitionProvider().draggingPosition,
      ),
    );
  }
}
