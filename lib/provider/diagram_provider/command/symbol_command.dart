import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';

class AddSymbolCommand extends DiagramCommand {
  final String symbol;

  const AddSymbolCommand({
    required this.symbol,
  });
}

class DeleteSymbolCommand extends DiagramCommand {
  final String symbol;

  const DeleteSymbolCommand({
    required this.symbol,
  });
}
