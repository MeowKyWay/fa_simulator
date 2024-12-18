// Todo implement a class that store all action e.g. create a state delete a state
// Use the class to undo and redo actions
// Maybe use interface to implement the actions
// All class need an undo redo and do function
// do is the function that is called when the action is done
// Change all the functions to use the class do function

import 'dart:developer';

import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';

class AppActionDispatcher extends DiagramProvider {
  static final AppActionDispatcher _instance = AppActionDispatcher._internal();
  AppActionDispatcher._internal();
  factory AppActionDispatcher() => _instance;

  // Store list of actions
  final List<AppAction> _actions = [];
  // Store list of undo actions
  final List<AppAction> _redoActions = [];

  void execute(AppAction action) {
    // Execute the action
    try {
      action.execute();
      // Add the action to the list if it is undoable
      if (action.isRevertable) {
        _actions.add(action);
        _redoActions.clear();
      }
      // Empty the redo list
    } on Exception catch (e) {
      log(e.toString());
    }
    _postAction();
  }

  void undo() {
    // If there are actions
    if (_actions.isNotEmpty) {
      // Undo the last action
      try {
        _actions.last.undo();
        // Add the action to the redo list
        _redoActions.add(_actions.last);
      } on Exception catch (e) {
        log(e.toString());
      }
      // Remove the action from the list
      _actions.removeLast();
    }
    _postAction();
  }

  void redo() {
    // If there are redo actions
    if (_redoActions.isNotEmpty) {
      // Redo the last action
      try {
        _redoActions.last.redo();
        // Add the action to the list
        _actions.add(_redoActions.last);
      } on Exception catch (e) {
        log(e.toString());
      }
      // Remove the action from the redo list
      _redoActions.removeLast();
    }
    _postAction();
  }

  void _postAction() {
    // log(_actions.toString());
  }

  @override
  void reset() {
    _actions.clear();
    _redoActions.clear();
  }
}
