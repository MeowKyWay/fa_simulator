import 'package:fa_simulator/config.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';



class StateList with ChangeNotifier {

  static final StateList _instance = StateList._internal(); //Singleton
  StateList._internal();
  factory StateList() {
    return _instance;
  }

  final List<DiagramState> _states = [];

  List<DiagramState> get states => _states;

  void addState(Offset position) {
    DiagramState state = DiagramState(
      position: position - const Offset(stateSize / 2, stateSize / 2),
      id: const Uuid().v4(),
      name: stateCounter.toString(),
    );
    _states.add(state);
    stateCounter++;
    requestFocus(state.id);
  }

  void deleteState(String id) {
    _states.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void renameState(String id, String newName) {
    for (var i = 0; i < _states.length; i++) {
      if (_states[i].id == id) {
        _states[i].name = newName;
      }
    }
    notifyListeners();
  }

  void moveState(String id, Offset position) {
    for (var i = 0; i < _states.length; i++) {
      if (_states[i].id == id) {
        _states[i].position = position;
      }
    }
    notifyListeners();
  }

  void requestFocus(String id) {
    for (var i = 0; i < _states.length; i++) {
      if (_states[i].id == id) {
        _states[i].hasFocus = true;
      } else {
        _states[i].hasFocus = false;
      }
    }
    notifyListeners();
  }

  void requestGroupFocus(List<String> ids) {
    for (var i = 0; i < _states.length; i++) {
      if (ids.contains(_states[i].id)) {
        _states[i].hasFocus = true;
      } else {
        _states[i].hasFocus = false;
      }
    }
    notifyListeners();
  }

  void addFocus(String id) {
    for (var i = 0; i < _states.length; i++) {
      if (_states[i].id == id) {
        _states[i].hasFocus = true;
      }
    }
    notifyListeners();
  }

  void unFocus() {
    for (var i = 0; i < _states.length; i++) {
      _states[i].hasFocus = false;
    }
    notifyListeners();
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
