import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
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
  bool isCurved = false;
  if (sourceStateId != null && destinationStateId != null) {
    if (DiagramList().getTransitionByState(sourceStateId, destinationStateId) !=
        null) {
      throw Exception(transitionAlreadyExistErrorMessage);
    }
  }
  TransitionType transition = TransitionType(
    id: id ?? const Uuid().v4(),
    label: label,
    sourceStateId: sourceStateId,
    destinationStateId: destinationStateId,
    sourcePosition: sourcePosition,
    destinationPosition: destinationPosition,
    isCurved: isCurved,
  );
  transition.updateIsCurved(true);
  // Add the transition to the list
  RenamingProvider().reset();
  DiagramList().items.add(transition);
  DiagramList().notify();
  // Return the transition
  return transition;
}

// Delete a state
void deleteTransition(String id) {
  // Get the state index
  int index = DiagramList().itemIndex(id);

  RenamingProvider().reset();
  if (index != -1) {
    if (DiagramList().items[index] is! TransitionType) {
      throw Exception("Item id $id is not a transition");
    }
    TransitionType transition = DiagramList().items[index] as TransitionType;
    transition.updateIsCurved(false);
    DiagramList().items.removeAt(index);
  } else {
    throw Exception(
        "transition_manager.dart/deleteTransition: Transition id $id not found");
  }

  DiagramList().notify();
}

//Only use to detach transition from state to body
//Or move a pivot from body to body
void moveTransition({
  required String id,
  required TransitionPivotType pivotType,
  Offset? distance,
  Offset? position,
}) {
  if ((distance ?? position) == null) {
    throw ArgumentError(
        "Either provide distance or position to move a transition pivot");
  }
  // Get the transition
  TransitionType transition;
  try {
    transition = DiagramList().transition(id)!;
  } catch (e) {
    throw Exception(
        "transition_manager.dart/moveTransition: Transition id $id not found");
  }

  Offset startPos = transition.startButtonPosition;
  Offset endPos = transition.endButtonPosition;
  transition.updateIsCurved(false);

  RenamingProvider().reset();
  switch (pivotType) {
    case TransitionPivotType.start:
      transition.sourcePosition = position ?? (startPos + distance!);
      transition.resetSourceState();
      break;
    case TransitionPivotType.end:
      transition.destinationPosition = position ?? (endPos + distance!);
      transition.resetDestinationState();
      break;
    case TransitionPivotType.all:
      transition.sourcePosition = position ?? (startPos + distance!);
      transition.destinationPosition = position ?? (endPos + distance!);
      transition.resetSourceState();
      transition.resetDestinationState();
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
    transition = DiagramList().transition(id)!;
  } catch (e) {
    throw Exception(
        "transition_manager.dart/attachTransition: Transition id $id not found");
  }

  RenamingProvider().reset();
  switch (endPoint) {
    case TransitionEndPointType.start:
      if (transition.destinationStateId != null) {
        if (DiagramList().getTransitionByState(
                stateId, transition.destinationStateId!) !=
            null) {
          throw Exception(transitionAlreadyExistErrorMessage);
        }
      }
      transition.sourceStateId = stateId;
      transition.resetSourcePosition();
      break;
    case TransitionEndPointType.end:
      if (transition.sourceStateId != null) {
        if (DiagramList()
                .getTransitionByState(transition.sourceStateId!, stateId) !=
            null) {
          throw Exception(transitionAlreadyExistErrorMessage);
        }
      }
      transition.destinationStateId = stateId;
      transition.resetDestinationPosition();
      break;
  }
  transition.updateIsCurved(true);
  DiagramList().notify();
}

String get transitionAlreadyExistErrorMessage =>
    "Transition with the same source state and destination state already exist";
