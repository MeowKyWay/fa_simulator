import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/action/diagram_clipboard.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/focus_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/state_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/accept_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/start_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:flutter/material.dart';

class PasteAction extends AppAction {
  @override
  bool isRevertable = true;

  final Map<String, String> _stateIdMap = {};
  final List<StateType> _states = [];
  final List<TransitionType> _transitions = [];

  @override
  void execute() {
    List<DiagramType> items = DiagramClipboard().items;

    DiagramClipboard().incrementCount();

    Offset margin = const Offset(subGridSize, subGridSize) *
        DiagramClipboard().count.toDouble();

    List<StateType> states = items.whereType<StateType>().toList();
    List<TransitionType> transitions =
        items.whereType<TransitionType>().toList();

    for (StateType state in states) {
      StateType newState;
      StateTypeEnum type = state is StartStateType
          ? StateTypeEnum.start
          : state is AcceptStateType
              ? StateTypeEnum.accept
              : StateTypeEnum.state;
      newState = addState(
        position: state.position + margin,
        name: state.label,
        type: type,
      );
      _states.add(newState);
      _stateIdMap[state.id] = newState.id;
    }

    for (TransitionType transition in transitions) {
      TransitionType newTransition;
      Offset? sourcePosition = transition.sourcePosition == null
          ? null
          : transition.sourcePosition! + margin;
      Offset? destinationPosition = transition.destinationPosition == null
          ? null
          : transition.destinationPosition! + margin;
      newTransition = addTransition(
        sourcePosition: sourcePosition,
        destinationPosition: destinationPosition,
        sourceStateId: _stateIdMap[transition.sourceStateId],
        destinationStateId: _stateIdMap[transition.destinationStateId],
        label: transition.label,
      );
      _transitions.add(newTransition);
    }
    requestFocus(_states.map((e) => e.id).toList());
    addFocus(_transitions.map((e) => e.id).toList());
  }

  @override
  void undo() {
    DiagramClipboard().decrementCount();
    for (TransitionType transition in _transitions) {
      deleteTransition(transition.id);
    }
    for (StateType state in _states) {
      deleteState(state.id);
    }
  }

  @override
  void redo() {
    for (StateType state in _states) {
      addState(
        position: state.position,
        name: state.label,
        type: state is StartStateType
            ? StateTypeEnum.start
            : state is AcceptStateType
                ? StateTypeEnum.accept
                : StateTypeEnum.state,
        id: state.id,
      );
    }
    for (TransitionType transition in _transitions) {
      addTransition(
        sourcePosition: transition.sourcePosition,
        destinationPosition: transition.destinationPosition,
        sourceStateId: transition.sourceStateId,
        destinationStateId: transition.destinationStateId,
        label: transition.label,
        id: transition.id,
      );
    }
    requestFocus(_states.map((e) => e.id).toList());
    addFocus(_transitions.map((e) => e.id).toList());
  }
}
