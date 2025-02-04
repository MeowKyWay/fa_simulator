import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/snackbar_provider.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:get/get.dart';

class AppActionDispatcher extends DiagramProvider {
  static final AppActionDispatcher _instance = AppActionDispatcher._internal();
  AppActionDispatcher._internal();
  factory AppActionDispatcher() => _instance;

  // Store list of actions
  final List<AppAction> _actions = [];
  // Store list of undo actions
  final List<AppAction> _redoActions = [];

  void execute(AppAction action, {Function? postAction}) async {
    // Execute the action
    try {
      await action.execute();
      // Add the action to the list if it is undoable
      if (action.isRevertable) {
        _actions.add(action);
        _redoActions.clear();
      }
      postAction?.call();
      // Empty the redo list
    } on Exception catch (e) {
      Get.find<SnackbarProvider>().showError(e.toString());
    }
    _postAction();
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
