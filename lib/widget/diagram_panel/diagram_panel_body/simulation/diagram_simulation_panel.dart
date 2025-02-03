import 'dart:developer';

import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
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

  void _onSubmitted() {
    String value = controller.text;
    final result = DiagramList().simulator.simulate(value.split(','));
    log('Result: ${result.item1}');
    log('Path: ${result.item2.map((e) => e.label).toList()}');
  }

  void _onClear() {
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputStringTextField(
            controller: controller,
            onSubmitted: _onSubmitted,
            onClear: _onClear,
          ),
          SimulationResultText(),
        ],
      ),
    );
  }
}
