import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

class FocusProvider extends DiagramProvider with ChangeNotifier {
  static final FocusProvider _instance = FocusProvider._internal();
  FocusProvider._internal();
  factory FocusProvider() {
    return _instance;
  }

  final Set<String> _focusItemIds = {};

  bool get isEmpty => _focusItemIds.isEmpty;
  bool get isNotEmpty => _focusItemIds.isNotEmpty;

  /// Add focus to the item with the provided id
  void addFocus(String id) {
    _focusItemIds.add(id);
    notifyListeners();
  }

  /// Add focus to each item with the provided ids
  void addFocusAll(Iterable<String> ids) {
    _focusItemIds.addAll(ids);
    notifyListeners();
  }

  /// Remove focus from the item with the provided id
  void removeFocus(String id) {
    _focusItemIds.remove(id);
    notifyListeners();
  }

  /// Remove focus from each item with the provided ids
  void removeFocusAll(Iterable<String> ids) {
    _focusItemIds.removeAll(ids);
    notifyListeners();
  }

  /// Remove focus from all items
  void clearFocus() {
    _focusItemIds.clear();
    notifyListeners();
  }

  /// Request focus for the item with the provided id
  /// This will remove focus from all other items
  void requestFocus(String id) {
    _focusItemIds.clear();
    _focusItemIds.add(id);
    notifyListeners();
  }

  /// Request focus for each item with the provided ids
  /// This will remove focus from all other items
  void requestFocusAll(Iterable<String> ids) {
    _focusItemIds.clear();
    _focusItemIds.addAll(ids);
    notifyListeners();
  }

  /// Toggle focus for the item with the provided id
  void toggleFocus(String id) {
    if (_focusItemIds.contains(id)) {
      _focusItemIds.remove(id);
    } else {
      _focusItemIds.add(id);
    }
    notifyListeners();
  }

  /// Unfocus all
  void unfocus() {
    _focusItemIds.clear();
    notifyListeners();
  }

  /// Toggle focus for each item with the provided ids
  void toggleFocusAll(Iterable<String> ids) {
    for (String id in ids) {
      if (_focusItemIds.contains(id)) {
        _focusItemIds.remove(id);
      } else {
        _focusItemIds.add(id);
      }
    }
    notifyListeners();
  }

  /// Return true if the item with the provided id is focused
  bool hasFocus(String id) {
    return _focusItemIds.contains(id);
  }

  /// Return every focused item id
  Set<String> get focusedItemIds {
    return Set<String>.from(_focusItemIds);
  }

  /// Return every id of every focused state
  Set<String> get focusedStateIds {
    return _focusItemIds.where((id) => DiagramList().isState(id)).toSet();
  }

  /// Return every focused state
  List<StateType> get focusedStates {
    return DiagramList().getStatesByIds(focusedStateIds);
  }

  /// Return every id of every focused transition
  Set<String> get focusedTransitionIds {
    return _focusItemIds.where((id) => DiagramList().isTransition(id)).toSet();
  }

  /// Return every focused transition
  List<TransitionType> get focusedTransitions {
    return DiagramList().getTransitionsByIds(focusedTransitionIds);
  }

  /// Return every focused item
  List<DiagramType> get focusedItems {
    return DiagramList().getItemsByIds(_focusItemIds);
  }

  @override
  void reset() {
    _focusItemIds.clear();
    notifyListeners();
  }
}
