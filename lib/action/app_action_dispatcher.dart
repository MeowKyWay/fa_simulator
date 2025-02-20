import 'dart:collection';

import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/snackbar_provider.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class AppActionDispatcher extends DiagramProvider {
  static final AppActionDispatcher _instance = AppActionDispatcher._internal();
  AppActionDispatcher._internal();
  factory AppActionDispatcher() => _instance;

  // Store list of actions
  final List<AppAction> _actions = [];
  // Store list of undo actions
  final List<AppAction> _redoActions = [];

  bool get canUndo => _actions.isNotEmpty;
  bool get canRedo => _redoActions.isNotEmpty;

  final Queue<Tuple2<AppAction, VoidCallback?>> _actionQueue = Queue();
  bool _isProcessing = false;

  void execute(AppAction action, {VoidCallback? postAction}) {
    _actionQueue.add(Tuple2(action, postAction)); // Add action to queue
    if (_isProcessing) return;
    _processQueue(); // Start processing if not already running
  }

  void _processQueue() async {
    if (_isProcessing || _actionQueue.isEmpty) return;

    _isProcessing = true;
    final action = _actionQueue.removeFirst(); // Get next action

    try {
      await action.item1.execute(); // Execute the action
      if (action.item1.isRevertable) {
        _actions.add(action.item1);
        _redoActions.clear();
      }
    } on Exception catch (e) {
      Get.find<SnackbarProvider>().showError(e.toString());
    }

    action.item2?.call(); // Call post action

    _isProcessing = false;
    if (_actionQueue.isNotEmpty) {
      _processQueue(); // Process next action
    }
  }

  void undo() async {
    // If there are actions
    if (_actions.isNotEmpty) {
      // Undo the last action
      try {
        await _actions.last.undo();
        // Add the action to the redo list
        _redoActions.add(_actions.last);
      } on Exception catch (e) {
        Get.find<SnackbarProvider>().showError(e.toString());
      }
      // Remove the action from the list
      _actions.removeLast();
    }
    _postAction();
  }

  void redo() async {
    // If there are redo actions
    if (_redoActions.isNotEmpty) {
      // Redo the last action
      try {
        await _redoActions.last.redo();
        // Add the action to the list
        _actions.add(_redoActions.last);
      } on Exception catch (e) {
        Get.find<SnackbarProvider>().showError(e.toString());
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
