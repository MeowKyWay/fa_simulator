import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/simulation/input_string_text_field.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/simulation/simulation_result_text.dart';
import 'package:flutter/material.dart';

class DiagramSimulationPanel extends StatefulWidget {
  const DiagramSimulationPanel({super.key});

  @override
  State<DiagramSimulationPanel> createState() => _DiagramSimulationPanelState();
}

class _DiagramSimulationPanelState extends State<DiagramSimulationPanel> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputStringTextField(controller: controller),
          SimulationResultText(),
        ],
      ),
    );
  }
}
