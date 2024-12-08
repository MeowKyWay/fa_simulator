import 'dart:developer';

import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

TransitionType addTransition({
  Offset? sourcePosition,
  Offset? destinationPosition,
  String? sourceStateId,
  String? destinationStateId,
  String label = "",
  String? id,
}) {
  TransitionType transition = TransitionType(
    id: id ?? const Uuid().v4(),
    label: label,
    sourceStateId: sourceStateId,
    destinationStateId: destinationStateId,
    sourcePosition: sourcePosition,
    destinationPosition: destinationPosition,
  );
  // Add the transition to the list
  DiagramList().resetRename();
  DiagramList().items.add(transition);
  DiagramList().notify();
  // Return the transition
  return transition;
}

// Delete a state
void deleteTransition(String id) {
  // Get the state index
  int index = DiagramList().itemIndex(id);

  DiagramList().resetRename();
  if (index != -1) {
    if (DiagramList().items[index] is! TransitionType) {
      throw Exception("Item id $id is not a transition");
    }
    DiagramList().items.removeAt(index);
  } else {
    throw Exception("Transition id $id not found");
  }

  DiagramList().notify();
}

//Only use to detach transition from state to body
//Or move a pivot from body to body
void moveTransition({
  required String id,
  required TransitionPivotType pivotType,
  required Offset distance,
}) {
  // Get the transition
  TransitionType transition;
  try {
    transition = DiagramList().transition(id);
  } catch (e) {
    throw Exception("Transition id $id not found");
  }

  DiagramList().resetRename();
  switch (pivotType) {
    case TransitionPivotType.start:
      transition.sourcePosition = transition.startButtonPosition + distance;
      transition.resetSourceState();
      break;
    case TransitionPivotType.end:
      transition.destinationPosition = transition.endButtonPosition + distance;
      transition.resetDestinationState();
      break;
    case TransitionPivotType.center:
      if (transition.centerPivot == null) {
        transition.centerPivot = transition.centerPosition + distance;
      } else {
        transition.centerPivot = transition.centerPivot! + distance;
      }
      break;
    case TransitionPivotType.all:
      if ((transition.sourceState ?? transition.destinationState) != null) {
        throw Exception(
            "Cannot move all pivot on transition that attached to a state");
      }
      transition.sourcePosition = transition.startButtonPosition + distance;
      transition.destinationPosition = transition.endButtonPosition + distance;
      transition.resetSourceState();
      transition.resetDestinationState();
      if (transition.centerPivot != null) {
        transition.centerPivot = transition.centerPivot! + distance;
      }
      break;
  }
  DiagramList().notify();
}

void attachTransition({
  required String id,
  required String stateId,
  required TransitionEndPointType endPoint,
}) {
  // Get the transition
  TransitionType transition;
  try {
    transition = DiagramList().transition(id);
  } catch (e) {
    throw Exception("Transition id $id not found");
  }

  DiagramList().resetRename();
  switch (endPoint) {
    case TransitionEndPointType.start:
      log("TransitionEndPointType.start");
      transition.sourceStateId = stateId;
      transition.resetSourcePosition();
      break;
    case TransitionEndPointType.end:
      transition.destinationStateId = stateId;
      transition.resetDestinationPosition();
      break;
  }
  DiagramList().notify();
}
