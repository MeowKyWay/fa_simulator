import 'package:fa_simulator/action/app_action.dart';

abstract class AppUnrevertableAction extends AppAction {
  @override
  bool get isRevertable => false;
  @override
  void undo() {
    throw Exception('This action is unrevertable action');
  }

  @override
  void redo() {
    throw Exception('This action is unrevertable action');
  }
}
