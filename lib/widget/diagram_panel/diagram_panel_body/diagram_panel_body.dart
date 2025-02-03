import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/diagram_simulation_panel.dart';
import 'package:flutter/material.dart';

class DiagramPanelBody extends StatelessWidget {
  final PageController controller;

  const DiagramPanelBody({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: controller,
        children: [
          Container(
            color: Colors.red,
          ),
          DiagramSimulationPanel(),
        ],
      ),
    );
  }
}
