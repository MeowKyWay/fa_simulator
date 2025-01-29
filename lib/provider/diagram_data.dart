import 'dart:collection';

import 'package:fa_simulator/widget/diagram/diagram_type/exception/diagram_exception.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/interface/jsonable.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_symbol.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:flutter/material.dart';
import 'package:sorted_list/sorted_list.dart';

enum AutomataType {
  dfa,
  nfa,
}

class DiagramNotifier extends ChangeNotifier implements Jsonable {
  AutomataType? _type;
  final SortedList<StateType> _states = SortedList(
    (a, b) => a.compareTo(b),
  );
  final SortedList<TransitionType> _transitions = SortedList(
    (a, b) => a.compareTo(b),
  );
  final SplayTreeSet<String> _alphabet = SplayTreeSet<String>();

  DiagramNotifier();

  // Getter
  /// Return the type of the automata
  AutomataType get type {
    return _type!;
  }

  /// Return clone of the states list
  List<StateType> get states {
    return _states.map((e) => e.clone).toList();
  }

  /// Return clone of the transitions list
  List<TransitionType> get transitions {
    return _transitions.map((e) => e.clone).toList();
  }

  /// Return clone of the alphabet
  List<String> get alphabet {
    return List<String>.from(_alphabet);
  }

  /// Return every unregistered symbol in the transitions
  List<String> get alphabetFromTransitions {
    final alphabet = SplayTreeSet<String>();
    for (final transition in _transitions) {
      alphabet.addAll(transition.symbols);
    }
    alphabet.removeAll(_alphabet);
    return List<String>.from(alphabet);
  }

  /// Return clone of the state of provided id
  StateType state(String id) {
    return _states.firstWhere((element) => element.id == id).clone;
  }

  /// Return clone of the transition of provided id
  TransitionType transition(String id) {
    return _transitions.firstWhere((element) => element.id == id).clone;
  }

  /// Return list of transition id that connected to the state of provided id
  List<String> transitionsOfState(String id) {
    return _transitions
        .where((element) =>
            element.sourceStateId == id || element.destinationStateId == id)
        .map((e) => e.id)
        .toList();
  }

  // Setter
  /// Set the type of the automata
  set type(AutomataType type) {
    _type = type;
    notifyListeners();
  }

  /// Add state to the states list
  void addState(StateType state) {
    _states.add(state);
    notifyListeners();
  }

  /// Add each state to the states list
  void addStates(Iterable<StateType> states) {
    _states.addAll(states);
    notifyListeners();
  }

  /// Add transition to the transitions list
  void addTransition(TransitionType transition) {
    _transitions.add(transition);
    notifyListeners();
  }

  /// Add each transition to the transitions list
  void addTransitions(Iterable<TransitionType> transitions) {
    _transitions.addAll(transitions);
    notifyListeners();
  }

  /// Add symbol to the alphabet
  void addSymbol(String symbol) {
    _alphabet.add(symbol);
    notifyListeners();
  }

  /// Add each symbol to the alphabet
  void addSymbols(Iterable<String> symbols) {
    _alphabet.addAll(symbols);
    notifyListeners();
  }

  /// Add each state and transition to the states and transitions list respectively
  void addDiagrams(
      Iterable<StateType> states, Iterable<TransitionType> transitions) {
    _states.addAll(states);
    _transitions.addAll(transitions);
    notifyListeners();
  }

  /// Update state of provided id in the detail
  void updateState(StateDetail detail) {
    final state = _state(detail.id);
    _updateState(state, detail);
    notifyListeners();
  }

  /// Update each state of provided id in the details
  void updateStates(Iterable<StateDetail> details) {
    for (final detail in details) {
      final state = _state(detail.id);
      _updateState(state, detail);
    }
    notifyListeners();
  }

  /// Update transition of provided id in the detail
  void updateTransition(TransitionDetail detail) {
    final transition = _transition(detail.id);
    _updateTransition(transition, detail);
    notifyListeners();
  }

  /// Update each transition of provided id in the details
  void updateTransitions(Iterable<TransitionDetail> details) {
    for (final detail in details) {
      final transition = _transition(detail.id);
      _updateTransition(transition, detail);
    }
    notifyListeners();
  }

  /// Delete state of provided id
  /// Aways delete any transition that connected to the state before calling this method
  void deleteState(String id) {
    _deleteState(id);
    notifyListeners();
  }

  /// Delete each state of provided id
  /// Aways delete any transition that connected to any state in the list before calling this method
  void deleteStates(Iterable<String> ids) {
    for (final id in ids) {
      _deleteState(id);
    }
    notifyListeners();
  }

  /// Delete transition of provided id
  void deleteTransition(String id) {
    _deleteTransition(id);
    notifyListeners();
  }

  /// Delete each transition of provided id
  void deleteTransitions(Iterable<String> ids) {
    for (final id in ids) {
      _deleteTransition(id);
    }
    notifyListeners();
  }

  /// Delete symbol from the alphabet
  /// Also delete the symbol from any transition that contains it
  void deleteSymbol(String symbol) {
    _deleteSymbol(symbol);
    notifyListeners();
  }

  /// Delete each symbol from the alphabet
  /// Also delete each symbol from any transition that contains it
  void deleteSymbols(Iterable<String> symbols) {
    for (final symbol in symbols) {
      _deleteSymbol(symbol);
    }
    notifyListeners();
  }

  /// Delete each state and transition of provided id
  /// Must delete any transition that connected to the state but not in the delete list before calling this method
  void deleteDiagrams(
      Iterable<String> stateIds, Iterable<String> transitionIds) {
    for (final id in transitionIds) {
      _deleteTransition(id);
    }
    for (final id in stateIds) {
      _deleteState(id);
    }
    notifyListeners();
  }

  // Private reference getter
  StateType _state(String id) {
    return _states.firstWhere((element) => element.id == id);
  }

  TransitionType _transition(String id) {
    return _transitions.firstWhere((element) => element.id == id);
  }

  // Private setter
  void _updateState(StateType state, StateDetail detail) {
    state.label = detail.label ?? state.label;
    state.position = detail.position ?? state.position;
    state.isInitial = detail.isInitial ?? state.isInitial;
    state.isFinal = detail.isFinal ?? state.isFinal;
  }

  void _updateTransition(TransitionType transition, TransitionDetail detail) {
    transition.label = detail.label ?? transition.label;
    transition.sourcePosition =
        detail.sourcePosition ?? transition.sourcePosition;
    transition.destinationPosition =
        detail.destinationPosition ?? transition.destinationPosition;
    transition.sourceStateId = detail.sourceStateId ?? transition.sourceStateId;
    transition.destinationStateId =
        detail.destinationStateId ?? transition.destinationStateId;
  }

  void _deleteState(String id) {
    if (transitionsOfState(id).isNotEmpty) {
      throw StateHasTransitionsException(
        'Cannot delete state $id because transitions are attached to it.',
      );
    }
    _states.removeWhere((element) => element.id == id);
  }

  void _deleteTransition(String id) {
    _transitions.removeWhere((element) => element.id == id);
  }

  void _deleteSymbol(String symbol) {
    for (final transition in _transitions) {
      transition.deleteSymbol(symbol);
    }
    _alphabet.remove(symbol);
  }

  Map<String, dynamic> toJson() {
    final states = _states.map((e) => e.toJson()).toList();
    final transitions = _transitions.map((e) => e.toJson()).toList();

    return {
      'type': _type == AutomataType.dfa ? 'dfa' : 'nfa',
      'alphabet': _alphabet.toList(),
      'states': states,
      'transitions': transitions,
    };
  }

  factory DiagramNotifier.fromJson(Map<String, dynamic> json) {
    final notifier = DiagramNotifier();
    final type = json['type'] == 'dfa' ? AutomataType.dfa : AutomataType.nfa;
    final alphabet = json['alphabet'] as List<String>;
    final states = (json['states'] as List).map((e) => StateType.fromJson(e));
    final transitions =
        (json['transitions'] as List).map((e) => TransitionType.fromJson(e));

    notifier._alphabet.addAll(alphabet);
    notifier._type = type;
    notifier._states.addAll(states);
    notifier._transitions.addAll(transitions);

    return notifier;
  }
}

class DiagramProvider extends InheritedNotifier<DiagramNotifier> {
  const DiagramProvider({
    super.key,
    super.notifier,
    required super.child,
  });

  static DiagramNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DiagramProvider>()!
        .notifier!;
  }
}

class StateDetail {
  String id;
  String? label;
  Offset? position;
  bool? isInitial;
  bool? isFinal;

  StateDetail({
    required this.id,
    this.label,
    this.position,
    this.isInitial,
    this.isFinal,
  });
}

class TransitionDetail {
  String id;
  String? label;
  Offset? sourcePosition;
  Offset? destinationPosition;
  String? sourceStateId;
  String? destinationStateId;
  double? loopAngle;
  bool? isCurved;

  TransitionDetail({
    required this.id,
    this.label,
    this.sourcePosition,
    this.destinationPosition,
    this.sourceStateId,
    this.destinationStateId,
    this.loopAngle,
    this.isCurved,
  })  : assert(!(sourcePosition != null && sourceStateId != null)),
        assert(!(destinationPosition != null && destinationStateId != null));
}
