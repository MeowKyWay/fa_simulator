import 'dart:developer';

import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/action/diagram_clipboard.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/state_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/components/extension/list_extension.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:flutter/material.dart';

class PasteAction extends AppAction {
  @override
  bool isRevertable = true;

  final Map<String, String> _stateIdMap = {};
  final List<StateType> _states = [];
  final List<TransitionType> _transitions = [];

  @override
  Future<void> execute() async {
    final json = await DiagramClipboard.getData();
    if (json.isEmpty) {
      return;
    }

    final items = DiagramListExtension.fromJson(json['items']);
    final Offset margin = -Offset(
          json['mousePosition']['dx'],
          json['mousePosition']['dy'],
        ) +
        BodyProvider().mousePosition;

    List<StateType> states = items.whereType<StateType>().toList();
    List<TransitionType> transitions =
        items.whereType<TransitionType>().toList();

    for (StateType state in states) {
      StateType newState;
      newState = StateType(
        position: state.position + margin,
        label: state.label,
        isInitial: state.isInitial,
        isFinal: state.isFinal,
        initialArrowAngle: state.initialArrowAngle,
      );
      log(newState.position.toString());
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
      newTransition = TransitionType(
        sourcePosition: sourcePosition,
        destinationPosition: destinationPosition,
        sourceStateId: _stateIdMap[transition.sourceStateId],
        destinationStateId: _stateIdMap[transition.destinationStateId],
        label: transition.label,
      );
      _transitions.add(newTransition);
    }

    DiagramList().executeCommands([
      for (StateType e in _states) AddStateCommand(state: e),
      for (TransitionType e in _transitions)
        AddTransitionCommand(transition: e),
    ]);
    FocusProvider().requestFocusAll(
      _states.map((e) => e.id).followedBy(_transitions.map((e) => e.id)),
    );
  }

  @override
  Future<void> undo() async {
    for (TransitionType transition in _transitions) {
      DiagramList().executeCommand(
        DeleteTransitionCommand(id: transition.id),
      );
    }
    for (StateType state in _states) {
      DiagramList().executeCommand(
        DeleteStateCommand(id: state.id),
      );
    }
  }

  @override
  Future<void> redo() async {
    for (StateType state in _states) {
      DiagramList().executeCommand(
        AddStateCommand(state: state),
      );
    }
    for (TransitionType transition in _transitions) {
      DiagramList().executeCommand(
        AddTransitionCommand(transition: transition),
      );
    }
    FocusProvider().requestFocusAll(
      _states.map((e) => e.id).followedBy(_transitions.map((e) => e.id)),
    );
  }
}
