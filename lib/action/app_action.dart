abstract class AppAction {
  bool get isRevertable;
  // Do the action
  void execute();
  // Undo the action
  void undo();
  // Redo the action usually the same as execute
  void redo();
}
