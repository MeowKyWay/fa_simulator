import 'package:fa_simulator/widget/diagram/draggable/draggable_overlay.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyDraggingOverlay extends StatelessWidget {
  const BodyDraggingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateList>(builder: (context, stateList, child) {
      return DraggableOverlay(
        states: stateList.states,
      );
    });
  }
}
