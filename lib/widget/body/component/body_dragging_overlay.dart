import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/draggable/draggable_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyDraggingOverlay extends StatelessWidget {
  const BodyDraggingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, diagramList, child) {
      return const DraggableOverlay();
    });
  }
}
