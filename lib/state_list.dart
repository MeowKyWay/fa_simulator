import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_state.dart';
import 'package:flutter/material.dart';

class StateList with ChangeNotifier {
  final List<DiagramState> _states = [];

  List<DiagramState> get states => _states;

  void addState(Offset position) {
    DiagramState state = DiagramState(
      position: position - const Offset(stateSize / 2, stateSize / 2),
      name: stateCounter.toString(),
    );
    _states.add(state);
    stateCounter++;
    notifyListeners();
  }

  void deleteState(String name) {
    _states.removeWhere((element) => element.name == name);
    notifyListeners();
  }

  void renameState(String name, String newName) {
    for (var i = 0; i < _states.length; i++) {
      if (_states[i].name == name) {
        _states[i].name = newName;
      }
    }
    notifyListeners();
  }

  void moveState(String name, Offset position) {
    for (var i = 0; i < _states.length; i++) {
      if (_states[i].name == name) {
        _states[i].position = position;
      }
    }
    notifyListeners();
  }
}
