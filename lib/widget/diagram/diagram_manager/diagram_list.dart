import 'dart:collection';

import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
import 'package:flutter/material.dart';

class DiagramList extends DiagramProvider with ChangeNotifier {
  //Singleton
  static final DiagramList _instance = DiagramList._internal();
  DiagramList._internal();
  factory DiagramList() {
    return _instance;
  }

  //Store the states and transitions
  final List<DiagramType> _items = [];
  //Alphabet
  final SplayTreeSet<String> _alphabet = SplayTreeSet<String>();

  SplayTreeSet<String> get alphabet => _alphabet;
  List<DiagramType> get items => _items;
  List<DiagramType> get itemsCopy {
    return List<DiagramType>.from(_items.map((e) => e.copyWith()));
  }

  // Add and remove alphabet
  void addAlphabet(String alphabet) {
    _alphabet.add(alphabet);
    notifyListeners();
  }

  void removeAlphabet(String alphabet) {
    _alphabet.remove(alphabet);
    notifyListeners();
  }

  void clearAlphabet() {
    _alphabet.clear();
    notifyListeners();
  }

  SplayTreeSet<String> get unregisteredAlphabet {
    SplayTreeSet<String> alphabet = SplayTreeSet<String>();
    for (TransitionType transition in transitions) {
      alphabet.addAll(transition.symbols);
    }
    alphabet.removeAll(_alphabet);
    return alphabet;
  }

  DiagramType addItem(DiagramType item) {
    if (itemIsExist(item.id)) {
      throw Exception(
          "diagram_list/addItem: Item with id ${item.id} already exist");
    }
    if (item is TransitionType) {
      if (item.destinationStateId != null && item.sourceStateId != null) {
        if (getTransitionByState(
                item.sourceStateId!, item.destinationStateId!) !=
            null) {
          throw Exception(
              "diagram_list/addItem: Transition with source state ${item.sourceStateId} and destination state ${item.destinationStateId} already exist");
        }
      }
      if (item.sourceStateId != null && item.sourceState == null) {
        throw Exception(
            "diagram_list/addItem: Source state with id ${item.sourceStateId} not found");
      }
      if (item.destinationStateId != null && item.destinationState == null) {
        throw Exception(
            "diagram_list/addItem: Destination state with id ${item.destinationStateId} not found");
      }
    }
    _items.add(item);
    notifyListeners();
    return item;
  }

  void addItems(List<DiagramType> items) {
    for (var item in items) {
      addItem(item);
    }
    notifyListeners();
  }

  void removeItem(String id, [bool force = false]) {
    int index = itemIndex(id);
    if (index != -1) {
      if (_items[index] is StateType && !force) {
        if ((_items[index] as StateType).transitionIds.isNotEmpty) {
          throw Exception(
              "diagram_list/removeItem: State with id $id has transition(s) delete any transition(s) connected to the state first");
        }
      }
      _items.removeAt(index);
    } else {
      throw Exception("diagram_list/removeItem: Item id $id not found");
    }
    notifyListeners();
  }

  void removeItems(List<String> ids) {
    for (var id in ids) {
      removeItem(id);
    }
    notifyListeners();
  }

  StateType? state(id) {
    try {
      return _items.firstWhere((element) => element.id == id) as StateType;
    } catch (e) {
      return null;
    }
  }

  List<StateType> get startStates {
    return states.where((i) => i.isInitial).toList();
  }

  List<StateType> get acceptStates {
    return states.where((i) => i.isFinal).toList();
  }

  TransitionType? transition(id) {
    try {
      return _items.firstWhere((element) => element.id == id) as TransitionType;
    } catch (e) {
      return null;
    }
  }

  DiagramType? item(id) {
    try {
      return _items.firstWhere((element) => element.id == id);
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
    return _items.where((element) => element.hasFocus).toList();
  }

  List<StateType> get focusedStates {
    return _items
        .whereType<StateType>()
        .where((element) => element.hasFocus)
        .toList();
  }

  List<TransitionType> get focusedTransitions {
    return _items
        .whereType<TransitionType>()
        .where((element) => element.hasFocus)
        .toList();
  }

  List<StateType> get states {
    return _items.whereType<StateType>().toList();
  }

  List<TransitionType> get transitions {
    return _items.whereType<TransitionType>().toList();
  }

  List<StateType> getStates(List<String> ids) {
    return states.where((element) => ids.contains(element.id)).toList();
  }

  List<TransitionType> getTransitions(List<String> ids) {
    return transitions.where((element) => ids.contains(element.id)).toList();
  }

  List<DiagramType> getItems(List<String> ids) {
    return _items.where((element) => ids.contains(element.id)).toList();
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
  bool itemIsExist(String id) => _items.any((element) => element.id == id);
  //return index of the state with the id
  int itemIndex(String id) => _items.indexWhere((element) => element.id == id);

  void notify() {
    notifyListeners();
  }

  @override
  void reset() {
    _items.clear();
    FileProvider().notifyListeners();
  }
}

enum FAType { dfa, nfa }
