import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/focus_overlay.dart';
import 'package:fa_simulator/widget/diagram/state/diagram_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyStates extends StatelessWidget {
  const BodyStates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, diagramList, child) {
      return Stack(children: [
        ...DiagramList().states.map((state) {
          return DiagramState(
            state: state,
          );
        }),
        ...DiagramList().focusedStates.map((state) {
          return FocusOverlay(
            position: state.position,
          );
        }),
      ]);
    });
  }
}
