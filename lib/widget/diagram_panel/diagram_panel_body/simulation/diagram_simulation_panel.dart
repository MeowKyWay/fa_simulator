import 'dart:developer';

import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/snackbar_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/simulation/input_string_text_field.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/simulation/simulation_result_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class DiagramSimulationPanel extends StatefulWidget {
  const DiagramSimulationPanel({super.key});

  @override
  State<DiagramSimulationPanel> createState() => _DiagramSimulationPanelState();
}

class _DiagramSimulationPanelState extends State<DiagramSimulationPanel>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();

  Tuple2<bool, List<Tuple2<StateType, String>>>? _result;

  @override
  bool get wantKeepAlive => true;

  void _onSubmitted() {
    log(DiagramList().validator.errors.errors.toString());
    if (DiagramList().validator.errors.hasError) {
      Get.find<SnackbarProvider>().showError(
        'DiagramHasErrorException: Please fix the diagram before simulating.',
      );
      return;
    }
    String value = _controller.text;
    setState(() {
      _result = DiagramList().simulator.simulate(value.split(','));
    });
  }

  void _onChange() {
    setState(() {
      _result = null;
    });
  }

  void _onClear() {
    setState(() {
      _controller.clear();
      _result = null;
    });
  }

  @override
  void initState() {
    super.initState();
    DiagramList().addListener(_onChange);
  }

  @override
  void dispose() {
    super.dispose();
    DiagramList().removeListener(_onChange);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputStringTextField(
            controller: _controller,
            onSubmitted: _onSubmitted,
            onChanged: _onChange,
            onClear: _onClear,
          ),
          SimulationResultText(
            result: _result,
          ),
        ],
      ),
    );
  }
}
