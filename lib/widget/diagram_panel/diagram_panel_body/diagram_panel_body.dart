import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/alphabet/diagram_alphabet_panel.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/definition/diagram_definition_panel.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/problems/diagram_problems_panel.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/simulation/diagram_simulation_panel.dart';
import 'package:flutter/material.dart';

class DiagramPanelBody extends StatefulWidget {
  final PageController controller;

  const DiagramPanelBody({
    super.key,
    required this.controller,
  });

  @override
  State<DiagramPanelBody> createState() => _DiagramPanelBodyState();
}

class _DiagramPanelBodyState extends State<DiagramPanelBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: widget.controller,
      children: [
        DiagramProblemsPanel(),
        DiagramDefinitionPanel(),
        DiagramAlphabetPanel(),
        DiagramSimulationPanel(),
      ],
    );
  }
}
