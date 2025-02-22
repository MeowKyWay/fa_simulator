import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/diagram/add_diagram_action.dart';
import 'package:fa_simulator/action/diagram/move_diagrams_action.dart';
import 'package:fa_simulator/action/transition/change_transition_loop_angle_action.dart';
import 'package:fa_simulator/action/transition/create_transition_action.dart';
import 'package:fa_simulator/action/transition/move_transitions_action.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/resource/diagram_constants.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_drag_data.dart';
import 'package:fa_simulator/widget/sidebar/palette/state/state_palette.dart';
import 'package:fa_simulator/widget/sidebar/palette/transition/transition_palette.dart';
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
  loop,
  end,
  all;

  TransitionEndPointType get endPointType {
    switch (this) {
      case TransitionPivotType.start:
        return TransitionEndPointType.start;
      case TransitionPivotType.end:
        return TransitionEndPointType.end;
      default:
        throw Exception('Invalid endpoint type');
    }
  }
}

enum TransitionEndPointType {
  start,
  end;

  TransitionPivotType get pivotType {
    switch (this) {
      case TransitionEndPointType.start:
        return TransitionPivotType.start;
      case TransitionEndPointType.end:
        return TransitionPivotType.end;
    }
  }
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
        if (details.data is DraggingTransitionType) {
          return _onWillAcceptDraggingTransition(
              details.data as DraggingTransitionType);
        }
        //On drag new transition add the transition
        if (details.data is NewTransitionType) {
          return _onWillAcceptNewTransition(details.data as NewTransitionType);
        }
        if (details.data is StatePaletteDragData) {
          return _onWillAcceptStatePalleteDragData(
              details.data as StatePaletteDragData);
        }
        if (details.data is TransitionPaletteDragData) {
          return _onWillAcceptTransitionPalleteDragData(
              details.data as PaletteDragData);
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
        } else if (details.data is StatePaletteDragData) {
          _onAcceptStatePalleteDragData(details.data as StatePaletteDragData);
        } else if (details.data is TransitionPaletteDragData) {
          _onAcceptTransitionPalleteDragData(
              details.data as TransitionPaletteDragData);
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

  bool _onWillAcceptStatePalleteDragData(StatePaletteDragData data) {
    PalleteFeedbackProvider().withinBody = true;
    return true;
  }

  bool _onWillAcceptTransitionPalleteDragData(PaletteDragData data) {
    PalleteFeedbackProvider().withinBody = true;
    return true;
  }

  void _onAcceptDraggingDiagram(DraggingDiagramType data) {
    AppActionDispatcher().execute(
      MoveDiagramsAction(
        ids: FocusProvider().focusedItemIds,
        deltaOffset: DiagramDraggingProvider().deltaPosition,
      ),
    );
  }

  void _onAcceptDraggingTransition(DraggingTransitionType data) {
    if (data.draggingPivot == TransitionPivotType.loop) {
      AppActionDispatcher().execute(
        ChangeTransitionLoopAngleAction(
          id: data.transition.id,
          angle: TransitionDraggingProvider().newLoopAngle,
        ),
      );
      return;
    }
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

  void _onAcceptStatePalleteDragData(StatePaletteDragData data) {
    DiagramType item;
    if (PalleteFeedbackProvider().position == null) return;
    Offset position =
        PalleteFeedbackProvider().position! + PalleteFeedbackProvider().margin;

    item = StateType(
      position: position,
      id: const Uuid().v4(),
      label: '',
      isInitial: data.isInitial,
      isFinal: data.isFinal,
    );
    PalleteFeedbackProvider().reset();
    AppActionDispatcher().execute(
      AddDiagramAction(item: item),
    );
  }

  void _onAcceptTransitionPalleteDragData(TransitionPaletteDragData data) {
    DiagramType item;
    if (PalleteFeedbackProvider().position == null) return;
    Offset position =
        PalleteFeedbackProvider().position! + PalleteFeedbackProvider().margin;

    item = TransitionType(
      sourcePosition: position + const Offset(-50, 50),
      destinationPosition: position + const Offset(50, -50),
      id: const Uuid().v4(),
      label: data.isEpsilon ? DiagramCharacter.epsilon : '',
    );
    PalleteFeedbackProvider().reset();
    AppActionDispatcher().execute(
      AddDiagramAction(item: item),
    );
  }
}
