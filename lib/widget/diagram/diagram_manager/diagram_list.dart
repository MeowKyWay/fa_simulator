import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:flutter/material.dart';

class DiagramList with ChangeNotifier {
  //Singleton
  static final DiagramList _instance = DiagramList._internal();
  DiagramList._internal();
  factory DiagramList() {
    return _instance;
  }

  //Store the states and transitions
  final List<DiagramType> items = [];

  StateType state(id) =>
      items.firstWhere((element) => element.id == id) as StateType;
  TransitionType transition(id) =>
      items.firstWhere((element) => element.id == id) as TransitionType;
  DiagramType item(id) => items.firstWhere((element) => element.id == id);

  //Renaming infomation
  String _renamingItemId = "";
  String _renamingItemInitialName = "";
  String renamingItemNewName = "";
  String get renamingItemId => _renamingItemId;
  String get renamingItemInitialName => _renamingItemInitialName;


  void startRename(String id, {String? initialName}) {
    _renamingItemId = id;
    _renamingItemInitialName = initialName?? item(id).name;
    notifyListeners();
  }

  void resetRename() {
    _renamingItemId = "";
    _renamingItemInitialName = "";
    renamingItemNewName = "";
  }

  void endRename() {
    resetRename();
    notifyListeners();
  }

  //return list of focused items
  List<DiagramType> get focusedItems {
    return items.where((element) => element.hasFocus).toList();
  }
  List<StateType> get focusedStates {
    return items.whereType<StateType>().where((element) => element.hasFocus).toList();
  }
  List<TransitionType> get focusedTransitions {
    return items.whereType<TransitionType>().where((element) => element.hasFocus).toList();
  }

  List<StateType> get states {
    return items.whereType<StateType>().toList();
  }
  List<TransitionType> get transitions {
    return items.whereType<TransitionType>().toList();
  }

  //return if state with the id already exist
  bool itemIsExist(String id) => items.any((element) => element.id == id);
  //return index of the state with the id
  int itemIndex(String id) => items.indexWhere((element) => element.id == id);

  void notify() {
    notifyListeners();
  }
}
