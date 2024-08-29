import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StateList with ChangeNotifier {
  //Singleton class
  static final StateList _instance = StateList._internal();
  StateList._internal();
  factory StateList() {
    return _instance;
  }

  final List<DiagramState> _states = [];
  String _renamingStateId = "";

  List<DiagramState> get states => _states;
  String get renamingStateId => _renamingStateId;

  //-------------------State-------------------
  // Add new state
  DiagramState addState(Offset position, String name, [String? id]) {
    if (_states.any((element) => element.id == id)) {
      throw Exception("State id $id already exists");
    }
    // Get snapped position
    Offset roundedPosition = snapPosition(position);
    // Create a new state
    DiagramState state = DiagramState(
      position: roundedPosition,
      id: (id != null) ? id : const Uuid().v4(),
      name: name,
    );
    // Add the state to the list
    _states.add(state);
    _endRename();
    notifyListeners();
    // Return the state
    return state;
  }

  // Delete a state
  void deleteState(String id) {
    // Remove the state from the list

    int index = _states.indexWhere((element) => element.id == id);
    if (index != -1) {
      _states.removeAt(index);
    } else {
      throw Exception("State id $id not found");
    }
    _endRename();
    notifyListeners();
  }

  // Delete all focused states
  void deleteFocusedStates() {
    // Remove all focused states from the list
    _states.removeWhere((element) => element.hasFocus);
    _endRename();
    notifyListeners();
  }

  // Move a state position
  void moveState(String id, Offset position) {
    // Get snapped position
    Offset roundedPosition = snapPosition(position);
    // Move the state
    int index = _states.indexWhere((element) => element.id == id);
    if (index != -1) {
      _states[index].position = roundedPosition;
    } else {
      throw Exception("State id $id not found");
    }
    _endRename();
    notifyListeners();
  }

  // Snap a state position to the grid
  Offset snapPosition(Offset position) {
    // return the snapped position to the grid
    return Offset(
      (position.dx / (gridSize / 5)).round() * (gridSize / 5),
      (position.dy / (gridSize / 5)).round() * (gridSize / 5),
    );
  }

  //-------------------Focus-------------------
  // Request focus for a state
  void requestFocus(String id) {
    for (int i = 0; i < states.length; i++) {
      // If the state is the requested state, set hasFocus to true
      if (states[i].id == id) {
        states[i].hasFocus = true;
      }
      // Else set hasFocus to false
      else {
        states[i].hasFocus = false;
      }
    }
    // Cancle renaming
    _endRename();
    notifyListeners();
  }

  // Request focus for a group of states
  void requestGroupFocus(List<String> ids) {
    for (var i = 0; i < _states.length; i++) {
      // If the state is in the group, set hasFocus to true
      if (ids.contains(_states[i].id)) {
        _states[i].hasFocus = true;
      }
      // Else set hasFocus to false
      else {
        _states[i].hasFocus = false;
      }
    }
    // Cancle renaming
    _endRename();
    notifyListeners();
  }

  // Add a state to the focus list
  void addFocus(String id) {
    int index = _states.indexWhere((element) => element.id == id);
    if (index != -1) {
      _states[index].hasFocus = true;
    } else {
      throw Exception("State id $id not found");
    }
    // Cancle renaming
    _endRename();
    notifyListeners();
  }

  // Remove all focus
  void unfocus() {
    for (var i = 0; i < _states.length; i++) {
      _states[i].hasFocus = false;
    }
    // Cancle renaming
    _endRename();
    notifyListeners();
  }

  //-------------------Drag-------------------
  // Start dragging a state
  void startDrag(String id) {
    for (var i = 0; i < StateList().states.length; i++) {
      // If the state is the requested state, set isDragging to true
      if (StateList().states[i].id == id) {
        StateList().states[i].isDragging = true;
      }
    }
    notifyListeners();
  }

  // End dragging a state
  void endDrag(String id) {
    for (var i = 0; i < StateList().states.length; i++) {
      // If the state is the requested state, set isDragging to false
      if (StateList().states[i].id == id) {
        StateList().states[i].isDragging = false;
      }
    }
    notifyListeners();
  }

  //-------------------Rename-------------------
  // Start renaming a state
  void startRename(String id) {
    _renamingStateId = id;
    notifyListeners();
  }

  // End renaming a state
  void _endRename() {
    _renamingStateId = "";
  }

  // End renaming a state
  void endRename() {
    _endRename();
    notifyListeners();
  }

  // Rename a state
  String renameState(String id, String newName) {
    // Rename the state
    String? oldName;
    for (var i = 0; i < _states.length; i++) {
      if (_states[i].id == id) {
        oldName = _states[i].name;
        _states[i].name = newName;
      }
    }
    if (oldName == null) {
      throw Exception("State not found");
    }
    notifyListeners();
    return oldName;
  }
}

class DiagramState {
  Offset position;
  String id;
  String name;
  bool hasFocus;
  bool isDragging;
  bool isRenaming;

  DiagramState({
    required this.position,
    required this.id,
    required this.name,
    this.hasFocus = false,
    this.isDragging = false,
    this.isRenaming = false,
  });
}
