import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Add new state
StateType addState(Offset position, String name, [String? id]) {
  // Generate a new id if id is null
  id = id ?? const Uuid().v4();
  // Check if the state id already exists
  if (DiagramList().itemIsExist(id)) {
    throw Exception("State id $id already exists");
  }
  // Get snapped position
  Offset roundedPosition = BodyProvider().getSnappedPosition(position);
  // Create a new state
  StateType state = StateType(
    position: roundedPosition,
    id: id,
    label: name,
  );
  // Add the state to the list
  DiagramList().resetRename();
  DiagramList().items.add(state);
  DiagramList().notify();
  // Return the state
  return state;
}

// Delete a state
void deleteState(String id) {
  // Get the state index
  int index = DiagramList().itemIndex(id);

  DiagramList().resetRename();
  if (index != -1) {
    if (DiagramList().items[index] is! StateType) {
      throw Exception("Item id $id is not a state");
    }
    DiagramList().items.removeAt(index);
  } else {
    throw Exception("State id $id not found");
  }

  DiagramList().notify();
}

// Move a state position
void moveState(String id, Offset distance) {
  Offset deltaPosition = BodyProvider().getSnappedPosition(distance);
  // Get the state
  StateType state;
  try {
    state = DiagramList().state(id)!;
  } catch (e) {
    throw Exception("State id $id not found");
  }

  DiagramList().resetRename();
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
    throw Exception("State id $id not found");
  }
  String oldName = state.label;
  state.label = newName;
  DiagramList().notify();
  return oldName;
}
