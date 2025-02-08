import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/alphabet/panel_alphabet_problem.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/alphabet/panel_alphabet_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiagramAlphabetPanel extends StatefulWidget {
  const DiagramAlphabetPanel({super.key});

  @override
  State<DiagramAlphabetPanel> createState() => _DiagramAlphabetPanelState();
}

class _DiagramAlphabetPanelState extends State<DiagramAlphabetPanel>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    TextStyle? style = Theme.of(context).textTheme.labelSmall;

    return Material(
      color: Colors.transparent,
      textStyle: style,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Consumer<DiagramList>(builder: (context, _, __) {
            return IntrinsicHeight(
              child: Column(
                spacing: 3,
                children: [
                  PanelAlphabetRow(),
                  PanelAlphabetProblem(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
