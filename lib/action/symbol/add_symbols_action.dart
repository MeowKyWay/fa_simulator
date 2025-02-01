import 'package:fa_simulator/action/app_unrevertable_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/command/symbol_command.dart';

class AddSymbolsAction extends AppUnrevertableAction {
  final Iterable<String> symbols;

  AddSymbolsAction({
    required this.symbols,
  });

  @override
  Future<void> execute() async {
    List<DiagramCommand> commands =
        symbols.map((symbol) => AddSymbolCommand(symbol: symbol)).toList();

    DiagramList().executeCommands(commands);
  }
}
