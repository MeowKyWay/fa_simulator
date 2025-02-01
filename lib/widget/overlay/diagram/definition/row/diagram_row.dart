import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/widget/components/diagram_tile.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:flutter/material.dart';

class DiagramRow extends StatelessWidget {
  final DiagramErrorList errors;
  const DiagramRow({
    super.key,
    required this.errors,
  });

  @override
  Widget build(BuildContext context) {
    final String name =
        '${DiagramList().file.name ?? 'unnamed'}.${DiagramList().type.name}';

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        DiagramTile(
          leading: 'Diagram:',
          body: name,
        ),
        DiagramTile(
          leading: 'Type:',
          body: DiagramList().type.name,
        ),
        DiagramTile(
          leading: 'States:',
          body: DiagramList().states.length.toString(),
        ),
        DiagramTile(
          leading: 'Transitions:',
          body: DiagramList().transitions.length.toString(),
        ),
        DiagramTile(
          leading: 'Errors:',
          body: errors.errorCount.toString(),
        ),
      ],
    );
  }
}
