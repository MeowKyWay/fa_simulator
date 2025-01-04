import 'package:fa_simulator/action/app_action.dart';

abstract class AppUnrevertableAction extends AppAction {
  @override
  bool get isRevertable => false;
  @override
  Future<void> undo() async {
    throw Exception('This action is unrevertable action');
  }

  @override
  Future<void> redo() async {
    throw Exception('This action is unrevertable action');
  }
}
