import 'dart:developer';

import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Add new state
StateType addState(Offset position, String name, [String? id]) {
  // Generate a new id if id is null
  id = id ?? const Uuid().v4();
  // Get snapped position
  Offset roundedPosition = BodyProvider().getSnappedPosition(position);
  // Create a new state
  StateType state = StateType(
    position: roundedPosition,
    id: id,
    label: name,
  );
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
    throw Exception("state_manager.dart/deleteState: Item id $id is not a state");
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
