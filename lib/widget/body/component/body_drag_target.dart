import 'dart:math';
import 'dart:developer' as developer;

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/diagram/add_diagram_action.dart';
import 'package:fa_simulator/action/diagram/move_diagrams_action.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
import 'package:fa_simulator/action/transition/move_transitions_action.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/accept_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/start_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_drag_data.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DraggingDiagramType {}

class DraggingStateType extends DraggingDiagramType {
  final StateType state;

  DraggingStateType({
    required this.state,
  });
}

enum TransitionPivotType {
  start,
  end,
  all,
}

enum TransitionEndPointType {
  start,
  end,
}

class DraggingTransitionType {
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
          return _onWillAcceptDraggingDiagram(
              details.data as DraggingDiagramType);
        }
        //On drag transition pivot move the pivot
        else if (details.data is DraggingTransitionType) {
          return _onWillAcceptDraggingTransition(
              details.data as DraggingTransitionType);
        }
        //On drag new transition add the transition
        else if (details.data is NewTransitionType) {
          return _onWillAcceptNewTransition(details.data as NewTransitionType);
        } else if (details.data is PaletteDragData) {
          return _onWillAcceptPalleteDragData(details.data as PaletteDragData);
        }
        return false;
      },
      onAcceptWithDetails: (details) {
        if (details.data is DraggingDiagramType) {
          _onAcceptDraggingDiagram(details.data as DraggingDiagramType);
        } else if (details.data is DraggingTransitionType) {
          _onAcceptDraggingTransition(details.data as DraggingTransitionType);
        } else if (details.data is NewTransitionType) {
          _onAcceptNewTransition(details.data as NewTransitionType);
        } else if (details.data is PaletteDragData) {
          _onAcceptPalleteDragData(details.data as PaletteDragData);
        }
      },
      onMove: (details) {},
      onLeave: (details) {
        PalleteFeedbackProvider().withinBody = false;
      },
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => Container(),
    );
  }

  bool _onWillAcceptDraggingDiagram(DraggingDiagramType data) {
    return true;
  }

  bool _onWillAcceptDraggingTransition(DraggingTransitionType data) {
    return true;
  }

  bool _onWillAcceptNewTransition(NewTransitionType data) {
    return true;
  }

  bool _onWillAcceptPalleteDragData(PaletteDragData data) {
    PalleteFeedbackProvider().withinBody = true;
    return true;
  }

  void _onAcceptDraggingDiagram(DraggingDiagramType data) {
    AppActionDispatcher().execute(
      MoveDiagramsAction(
        ids: DiagramList().focusedItems.map((e) => e.id).toList(),
        deltaOffset: DiagramDraggingProvider().deltaPosition,
      ),
    );
  }

  void _onAcceptDraggingTransition(DraggingTransitionType data) {
    AppActionDispatcher().execute(
      MoveTransitionsAction(
        inputs: [
          MoveTransitionActionInput(
            id: data.transition.id,
            pivotType: data.draggingPivot,
          ),
        ],
        deltaOffset: TransitionDraggingProvider().deltaOffset,
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

  void _onAcceptPalleteDragData(PaletteDragData data) {
    DiagramType item;
    if (PalleteFeedbackProvider().position == null) return;
    Offset position =
        PalleteFeedbackProvider().position! + PalleteFeedbackProvider().margin;

    switch (data) {
      case PaletteDragData.state:
        item = StateType(
          position: position,
          id: const Uuid().v4(),
          label: '',
        );
        break;
      case PaletteDragData.startState:
        item = StartStateType(
          position: position,
          id: const Uuid().v4(),
          label: '',
        );
        break;
      case PaletteDragData.acceptState:
        item = AcceptStateType(
          position: position,
          id: const Uuid().v4(),
          label: '',
        );
        break;
      case PaletteDragData.transition:
        item = TransitionType(
          sourcePosition: calculateNewPoint(position, stateSize / 2, pi / 4),
          destinationPosition:
              calculateNewPoint(position, stateSize / 2, 9 * pi / 4),
          id: const Uuid().v4(),
          label: '',
        );
        break;
    }
    PalleteFeedbackProvider().reset();
    AppActionDispatcher().execute(
      AddDiagramAction(item: item),
    );
  }
}
