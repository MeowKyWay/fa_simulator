
import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/diagram/delete_diagrams_action.dart';
import 'package:fa_simulator/action/transition/delete_transitions_action.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/keyboard/key_handler/handle_ctrl.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void handleKey(LogicalKeyboardKey key, BuildContext context) {
  if (KeyboardProvider().isCtrlPressed) {
    handleCtrl(key, context);
    return;
  }
  if (KeyboardProvider().modifierKeys.contains(LogicalKeyboardKey.altLeft)) {
    _handleAlt(key);
    return;
  }
  if (key == LogicalKeyboardKey.enter) {
    _handleEnter();
    return;
  }
  _handleKey(key);
}

void _handleAlt(LogicalKeyboardKey key) {
  //TODO implement
}

void _handleKey(LogicalKeyboardKey key) {
  //Back space
  if (key == LogicalKeyboardKey.backspace) {
    _handleBackspace();
    return;
  }
}

void _handleBackspace() {
  //Prevent delete a state when renaming
  if (RenamingProvider().renamingItemId != null) return;

  List<String> focusItemIds =
      DiagramList().focusedItems.map((item) => item.id).toList();
  if (focusItemIds.isEmpty) {
    return;
  }

  // Delete transition that connected to focused states before delete the states
  Set<String> transitionToBeDeleted = {};
  List<StateType> focusStates = DiagramList().focusedStates;
  for (StateType state in focusStates) {
    List<String> transitionIds = state.transitionIds;
    transitionIds =
        transitionIds.where((id) => !focusItemIds.contains(id)).toList();
    transitionToBeDeleted.addAll(transitionIds);
  }
  if (transitionToBeDeleted.isNotEmpty) {
    AppActionDispatcher()
        .execute(DeleteTransitionsAction(ids: transitionToBeDeleted.toList()));
  }
  AppActionDispatcher().execute(DeleteDiagramsAction(ids: focusItemIds));
}

void _handleEnter() {
  if (RenamingProvider().renamingItemId != null) return;

  List<DiagramType> focusedItems = DiagramList().focusedItems;
  if (focusedItems.length != 1) return;

  RenamingProvider().startRename(
    id: focusedItems.first.id,
  );
}
