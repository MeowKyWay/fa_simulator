import 'package:fa_simulator/widget/diagram/diagram_type/accept_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/start_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum StateTypeEnum { state, start, accept }

// Add new state
StateType addState({
  required Offset position,
  required String name,
  StateTypeEnum type = StateTypeEnum.state,
  String? id,
}) {
  // Generate a new id if id is null
  id = id ?? const Uuid().v4();
  // Get snapped position
  Offset roundedPosition = BodyProvider().getSnappedPosition(position);
  // Create a new state
  StateType state;
  switch (type) {
    case StateTypeEnum.state:
      state = StateType(
        id: id,
        position: roundedPosition,
        label: name,
      );
      break;
    case StateTypeEnum.start:
      state = StartStateType(
        id: id,
        position: roundedPosition,
        label: name,
      );
      break;
    case StateTypeEnum.accept:
      state = AcceptStateType(
        id: id,
        position: roundedPosition,
        label: name,
      );
      break;
  }
  // Add the state to the list
  RenamingProvider().reset();
  DiagramList().addItem(state);
  // Return the state
  return state;
}

// Delete a state
void deleteState(String id) {
  // Get the state index

  RenamingProvider().reset();
  if (DiagramList().item(id) is! StateType) {
    throw Exception(
        "state_manager.dart/deleteState: Item id $id is not a state");
  }
  DiagramList().removeItem(id);
}

// Move a state position
void moveState(String id, Offset distance) {
  Offset deltaPosition = BodyProvider().getSnappedPosition(distance);
  // Get the state
  StateType state;
  try {
    state = DiagramList().state(id)!;
  } catch (e) {
    throw Exception("state_manager.dart/moveState: State id $id not found");
  }

  RenamingProvider().reset();
  state.position += deltaPosition;
  DiagramList().notify();
}

// Rename a state
String renameState(String id, String newName) {
  // Rename the state
  StateType state;
  try {
    state = DiagramList().state(id)!;
  } catch (e) {
    throw Exception("state_manager.dart/renameState: State id $id not found");
  }
  String oldName = state.label;
  state.label = newName;
  DiagramList().notify();
  return oldName;
}

void changeStateType({
  required String id,
  required StateTypeEnum type,
}) {
  StateType state;
  try {
    state = DiagramList().state(id)!;
  } catch (e) {
    throw Exception(
        "state_manager.dart/changeStateType: State id $id not found");
  }
  StateType newState;
  switch (type) {
    case StateTypeEnum.state:
      newState = StateType(
        id: state.id,
        position: state.position,
        label: state.label,
      );
      break;
    case StateTypeEnum.start:
      newState = StartStateType(
        id: state.id,
        position: state.position,
        label: state.label,
      );
      break;
    case StateTypeEnum.accept:
      newState = AcceptStateType(
        id: state.id,
        position: state.position,
        label: state.label,
      );
      break;
  }
  for (String id in state.incomingTransitionIds) {
    DiagramList().transition(id)!.destinationStateId = newState.id;
  }
  for (String id in state.outgoingTransitionIds) {
    DiagramList().transition(id)!.sourceStateId = newState.id;
  }
  DiagramList().removeItem(id, true);
  DiagramList().addItem(newState);
}
