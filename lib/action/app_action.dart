abstract class AppAction {
  bool get isRevertable;
  // Do the action
  Future<void> execute();
  // Undo the action
  Future<void> undo();
  // Redo the action usually the same as execute
  Future<void> redo();
}
