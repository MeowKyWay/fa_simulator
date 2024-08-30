
//TODO make everything an action
//including focus

abstract class AppAction {
  bool get isUndoable;
  // Do the action
  void execute();
  // Undo the action
  void undo();
  // Redo the action usually the same as execute
  void redo();
}
