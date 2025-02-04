import 'dart:collection';
import 'dart:developer';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/state_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/symbol_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_compiler.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_file.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_simulator.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_validator.dart';
import 'package:fa_simulator/resource/diagram_character.dart';
import 'package:fa_simulator/resource/diagram_exception.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/exception/diagram_exception.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/interface/jsonable.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_symbol.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

enum AutomataType {
  dfa,
  nfa,
  undefined;

  static AutomataType fromString(String type) {
    switch (type) {
      case 'dfa':
        return AutomataType.dfa;
      case 'nfa':
        return AutomataType.nfa;
      default:
        throw ArgumentError('Invalid automata type: $type');
    }
  }

  @override
  String toString() {
    switch (this) {
      case AutomataType.dfa:
        return 'dfa';
      case AutomataType.nfa:
        return 'nfa';
      default:
        return 'undefined';
    }
  }
}

class DiagramList extends DiagramProvider
    with ChangeNotifier
    implements Jsonable {
  //Singleton
  static final DiagramList _instance = DiagramList._internal();
  DiagramList._internal();
  factory DiagramList() {
    return _instance;
  }

  AutomataType _type = AutomataType.undefined;
  final SplayTreeSet<StateType> _states = SplayTreeSet<StateType>(
    (a, b) => a.createdAt.compareTo(b.createdAt),
  );
  final SplayTreeSet<TransitionType> _transitions =
      SplayTreeSet<TransitionType>(
    (a, b) => a.createdAt.compareTo(b.createdAt),
  );
  final SplayTreeSet<String> _alphabet = SplayTreeSet<String>();

  DiagramValidator _validator = DiagramValidator();
  DiagramCompiler _compiler = DiagramCompiler();
  DiagramSimulator _simulator = DiagramSimulator();
  DiagramFile _file = DiagramFile();

  DiagramValidator get validator {
    return _validator;
  }

  DiagramCompiler get compiler {
    return _compiler;
  }

  DiagramSimulator get simulator {
    return _simulator;
  }

  DiagramFile get file {
    return _file;
  }

  // Getter
  /// Return the type of the automata
  AutomataType get type {
    return _type;
  }

  /// Return clone of the states list
  List<StateType> get states {
    return _states.map((e) => e.clone).toList();
  }

  /// Return clone of the initial states list
  List<StateType> get initialStates {
    return List<StateType>.from(
        _states.where((element) => element.isInitial).map((e) => e.clone));
  }

  /// Return clone of the final states list
  List<StateType> get finalStates {
    return List<StateType>.from(
        _states.where((element) => element.isFinal).map((e) => e.clone));
  }

  /// Return clone of the transitions list
  List<TransitionType> get transitions {
    return _transitions.map((e) => e.clone).toList();
  }

  /// Return clone of the alphabet
  List<String> get alphabet {
    return List<String>.from(_alphabet);
  }

  /// Return every item in the diagram
  List<DiagramType> get items {
    List<DiagramType> items = [];
    items.addAll(states.map((e) => e.clone));
    items.addAll(transitions.map((e) => e.clone));
    return items;
  }

  /// Return every symbol in the transitions
  List<String> get symbolsFromTransitions {
    final alphabet = SplayTreeSet<String>();
    for (final transition in _transitions) {
      alphabet.addAll(transition.symbols);
    }
    return List<String>.from(alphabet);
  }

  /// Return every unregistered symbol in the transitions
  List<String> get unregisteredSymbols {
    final symbols = SplayTreeSet<String>.from(symbolsFromTransitions);
    symbols.removeAll(_alphabet);
    if (_type == AutomataType.dfa) symbols.remove(DiagramCharacter.epsilon);
    return symbols.toList();
  }

  List<String> get illegalSymbols {
    if (_type == AutomataType.dfa) {
      return allSymbol.contains(DiagramCharacter.epsilon)
          ? [DiagramCharacter.epsilon]
          : [];
    }
    return [];
  }

  /// Return every symbol in both the transitions and the alphabet
  List<String> get allSymbol {
    return (Set<String>.from(_alphabet)..addAll(symbolsFromTransitions))
        .toList();
  }

  /// Return true if the item with the provided id is a state
  bool isState(String id) {
    return _states.any((element) => element.id == id);
  }

  /// Return true if the item with the provided id is a transition
  bool isTransition(String id) {
    return _transitions.any((element) => element.id == id);
  }

  /// Return clone of the state of provided id.
  ///
  /// @throws StateError if the item is not found.
  StateType state(String id) {
    return _states.firstWhere((element) => element.id == id).clone;
  }

  /// Return clone of the transition of provided id.
  ///
  /// @throw StateError if the item is not found.
  TransitionType transition(String id) {
    return _transitions.firstWhere((element) => element.id == id).clone;
  }

  /// Return clone of the transition of provided source and destination state.
  ///
  /// @throw StateError if the transition is not found.
  TransitionType getTransitionByStates(String sourceId, String destinationId) {
    return _transitions.firstWhere(
      (element) =>
          element.sourceStateId == sourceId &&
          element.destinationStateId == destinationId,
    );
  }

  /// Return clone of an item of provided id.
  ///
  /// @throw StateError if the item is not found.
  DiagramType item(String id) {
    try {
      return state(id);
    } catch (e) {
      try {
        return transition(id);
      } catch (e) {
        throw StateError(
          'Cannot get diagram with id $id because it is not found.',
        );
      }
    }
  }

  /// Return list of clone of state of provided ids.
  ///
  /// If the item of an id is not found, it will be ignored.
  List<StateType> getStatesByIds(Iterable<String> ids) {
    return _states
        .where((element) => ids.contains(element.id))
        .map((e) => e.clone)
        .toList();
  }

  /// Return list of clone of transition of provided ids.
  ///
  /// If the item of an id is not found, it will be ignored.
  List<TransitionType> getTransitionsByIds(Iterable<String> ids) {
    return _transitions
        .where((element) => ids.contains(element.id))
        .map((e) => e.clone)
        .toList();
  }

  /// Return list of clone of state and transition of provided ids.
  ///
  /// If the item of an id is not found, it will be ignored.
  List<DiagramType> getItemsByIds(Iterable<String> ids) {
    List<DiagramType> items = [];
    items.addAll(getStatesByIds(ids));
    items.addAll(getTransitionsByIds(ids));
    return items;
  }

  /// Return list of transition id that connected to the state of provided id.
  List<String> transitionsOfState(String id) {
    return _transitions
        .where((element) =>
            element.sourceStateId == id || element.destinationStateId == id)
        .map((e) => e.id)
        .toList();
  }

  /// Return true if the transition of provided source and destination state is exist.
  bool transitionOfStateIsExist(String? sourceId, String? destinationId) {
    if (sourceId == null || destinationId == null) {
      return false;
    }
    try {
      getTransitionByStates(sourceId, destinationId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Setter
  /// Set the type of the automata.
  set type(AutomataType type) {
    _type = type;
    notify();
  }

  void executeCommand(DiagramCommand command) {
    executeCommands([command]);
  }

  /// Exucute the provided commands.
  ///
  /// Update:
  /// @throws StateError if the item is not found.
  ///
  /// Delete:
  ///   - Deleting a symbol will remove the symbol from the alphabet and any transition that contains it.
  /// @throws StateError if the item is not found.
  /// @throws StateHasTransitionsException if the state has transitions attached to it.
  void executeCommands(Iterable<DiagramCommand> commands) {
    for (final command in commands) {
      if (command is AddStateCommand) _addState(command);
      if (command is AddTransitionCommand) _addTransition(command);
      if (command is AddSymbolCommand) _addSymbol(command);
      if (command is AddItemCommand) _addItem(command);
      if (command is UpdateStateCommand) _updateState(command);
      if (command is UpdateTransitionCommand) _updateTransition(command);
      if (command is UpdateItemCommand) _updateItem(command);
      if (command is UpdateAlphabetCommand) _updateAlphabet(command);
      if (command is DeleteStateCommand) _deleteState(command);
      if (command is DeleteTransitionCommand) _deleteTransition(command);
      if (command is DeleteSymbolCommand) _deleteSymbol(command);
      if (command is DeleteItemCommand) _deleteItem(command);
      if (command is MoveStateCommand) _moveState(command);
      if (command is MoveTransitionCommand) _moveTransition(command);
      if (command is AttachTransitionCommand) _attachTransition(command);
    }
    notify();
  }

  // Private reference getter

  StateType _state(String id) {
    return _states.firstWhere((element) => element.id == id);
  }

  TransitionType _transition(String id) {
    return _transitions.firstWhere((element) => element.id == id);
  }

  DiagramType _item(String id) {
    try {
      return _state(id);
    } catch (e) {
      return _transition(id);
    }
  }

  // Private setter / updater

  /// Add state to the states list.
  void _addState(AddStateCommand command) {
    _states.add(command.state);
  }

  /// Add transition to the transitions list.
  void _addTransition(AddTransitionCommand command) {
    _transitions.add(command.transition);
  }

  /// Add symbol to the alphabet.
  void _addSymbol(AddSymbolCommand command) {
    _alphabet.add(command.symbol);
  }

  /// Add item to the states or transitions list depending on the item type.
  void _addItem(AddItemCommand command) {
    if (command.item is StateType) {
      _states.add(command.item as StateType);
    } else if (item is TransitionType) {
      _transitions.add(command.item as TransitionType);
    }
  }

  /// Update state of provided id in the detail.
  ///
  /// if the detail is null, the value will be preserved.
  ///
  /// @throws StateError if the state is not found.
  void _updateState(UpdateStateCommand command) {
    final state = _state(command.detail.id);
    //remove and readd to preserve the sorted list
    _states.remove(state);
    state.label = command.detail.label ?? state.label;
    state.position = command.detail.position ?? state.position;
    state.isInitial = command.detail.isInitial ?? state.isInitial;
    state.isFinal = command.detail.isFinal ?? state.isFinal;
    state.initialArrowAngle =
        command.detail.initialArrowAngle ?? state.initialArrowAngle;
    _states.add(state);
  }

  /// Update transition of provided id in the detail.
  ///
  /// @throws StateError if the transition is not found.
  void _updateTransition(UpdateTransitionCommand command) {
    final transition = _transition(command.detail.id);
    //remove and readd to preserve the sorted list
    _transitions.remove(transition);
    TransitionDetail detail = command.detail;
    transition.label = detail.label ?? transition.label;
    if ((detail.sourcePosition ?? detail.sourceStateId) != null) {
      transition.sourcePosition = detail.sourcePosition;
      transition.sourceStateId = detail.sourceStateId;
    }
    if ((detail.destinationPosition ?? detail.destinationStateId) != null) {
      transition.destinationPosition = detail.destinationPosition;
      transition.destinationStateId = detail.destinationStateId;
    }
    transition.loopAngle = detail.loopAngle ?? transition.loopAngle;
    _transitions.add(transition);
  }

  void _updateItem(UpdateItemCommand command) {
    DiagramType item = _item(command.detail.id);
    //remove and readd to preserve the sorted list
    if (item is StateType) {
      _states.remove(item);
      item.label = command.detail.label ?? item.label;
      _states.add(item);
    }
    if (item is TransitionType) {
      _transitions.remove(item);
      item.label = command.detail.label ?? item.label;
      _transitions.add(item);
    }
  }

  /// Update the alphabet with the provided symbols.
  void _updateAlphabet(UpdateAlphabetCommand command) {
    _alphabet.clear();
    for (String symbol in command.alphabet) {
      symbol = symbol.trim();
      if (symbol.isEmpty) {
        continue;
      }
      if (symbol == '\\e') {
        symbol = DiagramCharacter.epsilon;
        if (_type == AutomataType.dfa) {
          continue;
        }
      }
      _alphabet.add(symbol.trim());
    }
  }

  /// Delete state of provided id.
  ///
  /// @throws StateHasTransitionsException if the state has transitions attached to it.
  void _deleteState(DeleteStateCommand command) {
    if (transitionsOfState(command.id).isNotEmpty) {
      throw StateHasTransitionsException(
        'Cannot delete state ${command.id} because transitions are attached to it.',
      );
    }
    _states.removeWhere((element) => element.id == command.id);
  }

  /// Delete transition of provided id.
  void _deleteTransition(DeleteTransitionCommand command) {
    _transitions.removeWhere((element) => element.id == command.id);
  }

  /// Delete symbol from the alphabet.
  ///
  /// Also delete the symbol from any transition that contains it.
  void _deleteSymbol(DeleteSymbolCommand command) {
    for (final transition in _transitions) {
      transition.deleteSymbol(command.symbol);
    }
    _alphabet.remove(command.symbol);
  }

  /// Delete item of provided id.
  ///
  /// @throws StateError if the item is not found
  /// @throws StateHasTransitionsException if the item is a state and has transitions attached to it
  void _deleteItem(DeleteItemCommand command) {
    if (_states.any((element) => element.id == command.id)) {
      _deleteState(DeleteStateCommand(id: command.id));
    } else if (_transitions.any((element) => element.id == command.id)) {
      _deleteTransition(DeleteTransitionCommand(id: command.id));
    } else {
      throw StateError(
        'Cannot delete diagram with id ${command.id} because it is not found.',
      );
    }
  }

  /// Move state by either distance or position.
  ///
  /// Move the state by the distance or to the position.
  ///
  /// @throws ArgumentError if the distance and position are both provided or null.
  /// @throws StateError if the state is not found.
  void _moveState(MoveStateCommand command) {
    if ((command.distance ?? command.position) == null) {
      throw ArgumentError(
        'Either provide distance or position to move a transition pivot.',
      );
    }
    final state = _state(command.id);
    state.position = command.position ?? (state.position + command.distance!);
  }

  /// Move transition by either distance or position.
  ///
  /// Move the transition pivot by the distance or to the position.
  /// If the pivot is attach to a state, the pivot will be detached.
  ///
  /// @throws ArgumentError if the distance and position are both provided or null.
  /// @throws StateError if the transition is not found.
  void _moveTransition(MoveTransitionCommand command) {
    if ((command.distance ?? command.position) == null) {
      throw ArgumentError(
        'Either provide distance or position to move a transition pivot.',
      );
    }
    final transition = _transition(command.id);
    Offset startPos = transition.startButtonPosition;
    Offset endPos = transition.endButtonPosition;
    if (command.pivotType == TransitionPivotType.start ||
        command.pivotType == TransitionPivotType.all) {
      transition.sourcePosition =
          command.position ?? (startPos + command.distance!);
      transition.resetSourceState();
    }
    if (command.pivotType == TransitionPivotType.end ||
        command.pivotType == TransitionPivotType.all) {
      transition.destinationPosition =
          command.position ?? (endPos + command.distance!);
      transition.resetDestinationState();
    }
    notifyListeners();
  }

  /// Attach transition to the state.
  ///
  /// Attach the transition pivot to the state.
  /// If the pivot is already attached to a state, the pivot will be detached.
  ///
  /// @throws StateError if the transition or the state is not found.
  void _attachTransition(AttachTransitionCommand command) {
    final transition = _transition(command.id);
    state(command.stateId); // Check if the state is exist
    // Check if transition with the same source and destination state is exist
    String? sourceId = command.pivotType == TransitionEndPointType.start
        ? command.stateId
        : transition.sourceStateId;
    String? destinationId = command.pivotType == TransitionEndPointType.end
        ? command.stateId
        : transition.destinationStateId;
    if (transitionOfStateIsExist(sourceId, destinationId)) {
      throw TransitionAlreadyExistException(
        'Transition with the same source and destination state already exist.',
      );
    }
    switch (command.pivotType) {
      case TransitionEndPointType.start:
        transition.sourceStateId = command.stateId;
        transition.resetSourcePosition();
        break;
      case TransitionEndPointType.end:
        transition.destinationStateId = command.stateId;
        transition.resetDestinationPosition();
        break;
    }
  }

  @override
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

  void loadJson(Map<String, dynamic> json) {
    reset();
    final type = AutomataType.fromString(json['type']);
    final alphabet = json['alphabet'] as List<String>;
    final states = (json['states'] as List).map((e) => StateType.fromJson(e));
    final transitions =
        (json['transitions'] as List).map((e) => TransitionType.fromJson(e));

    _type = type;
    _alphabet.addAll(alphabet);
    _states.addAll(states);
    _transitions.addAll(transitions);
  }

  void notify() {
    compiler.compile();
    validator.validate();
    file.isSaved = false;
    notifyListeners();
  }

  @override
  void reset() {
    _type = AutomataType.undefined;
    _states.clear();
    _transitions.clear();
    _alphabet.clear();
    _validator = DiagramValidator();
    _compiler = DiagramCompiler();
    _file = DiagramFile();
    log(file.isSaved.toString());
    notifyListeners();
    log(file.isSaved.toString());
  }
}
