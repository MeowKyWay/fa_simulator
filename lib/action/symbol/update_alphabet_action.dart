import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';

class UpdateAlphabetAction extends AppUnrevertableAction {
  final Iterable<String> symbols;

  UpdateAlphabetAction({
    required this.symbols,
  });

  @override
  Future<void> execute() async {
    DiagramList().executeCommand(UpdateAlphabetCommand(alphabet: symbols));
  }
}
