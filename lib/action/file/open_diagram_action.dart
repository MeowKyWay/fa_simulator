import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/file/diagram_load.dart';

class OpenDiagramAction extends AppUnrevertableAction {
  @override
  Future<void> execute() async {
    try {
      await DiagramLoad().load();
    } on Exception catch (e) {
      throw Exception('Failed to open diagram: $e');
    }
  }
}
