import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:flutter/material.dart';

class DiagramList with ChangeNotifier {
  //Singleton
  static final DiagramList _instance = DiagramList._internal();
  DiagramList._internal();
  factory DiagramList() {
    return _instance;
  }

  //Store the states and transitions
  final List<DiagramType> _items = [];
  List<DiagramType> get items => _items;

  StateType? state(id) {
    try {
      return items.firstWhere((element) => element.id == id) as StateType;
    } catch (e) {
      return null;
    }
  }

  TransitionType? transition(id) {
    try {
      return items.firstWhere((element) => element.id == id) as TransitionType;
    } catch (e) {
      return null;
    }
  }

  DiagramType? item(id) {
    try {
      return items.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  String _hoveringStateId = "";
  String get hoveringStateId => _hoveringStateId;
  set hoveringStateId(String id) {
    _hoveringStateId = id;
    notifyListeners();
  }

  bool hoveringStateFlag = false;

  //return list of focused items
  List<DiagramType> get focusedItems {
    return items.where((element) => element.hasFocus).toList();
  }

  List<StateType> get focusedStates {
    return items
        .whereType<StateType>()
        .where((element) => element.hasFocus)
        .toList();
  }

  List<TransitionType> get focusedTransitions {
    return items
        .whereType<TransitionType>()
        .where((element) => element.hasFocus)
        .toList();
  }

  List<StateType> get states {
    return items.whereType<StateType>().toList();
  }

  List<TransitionType> get transitions {
    return items.whereType<TransitionType>().toList();
  }

  List<StateType> getStates(List<String> ids) {
    return states.where((element) => ids.contains(element.id)).toList();
  }

  List<TransitionType> getTransitions(List<String> ids) {
    return transitions.where((element) => ids.contains(element.id)).toList();
  }

  List<DiagramType> getItems(List<String> ids) {
    return items.where((element) => ids.contains(element.id)).toList();
  }

  TransitionType? getTransitionByState(
      String sourceStateId, String destinationStateId) {
    try {
      return transitions.firstWhere((element) =>
          element.sourceStateId == sourceStateId &&
          element.destinationStateId == destinationStateId);
    } catch (e) {
      return null;
    }
  }

  String renameItem(String id, String name) {
    DiagramType? item = this.item(id);
    if (item == null) {
      throw Exception("diagram_list/renameItem: Item with id $id not found");
    }
    String oldName = item.label;
    item.label = name;
    notifyListeners();
    return oldName;
  }

  //return if state with the id already exist
  bool itemIsExist(String id) => items.any((element) => element.id == id);
  //return index of the state with the id
  int itemIndex(String id) => items.indexWhere((element) => element.id == id);

  void notify() {
    notifyListeners();
  }
}
