import 'package:fa_simulator/widget/diagram/focus_overlay.dart';
import 'package:fa_simulator/widget/diagram/state/diagram_state.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyStates extends StatelessWidget {
  const BodyStates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StateList>(builder: (context, stateList, child) {
      return Stack(children: [
        ...stateList.states.map((state) {
          return DiagramState(
            state: state,
          );
        }),
        ...stateList.states.where((state) => state.hasFocus).map((state) {
          return FocusOverlay(
            position: state.position,
          );
        }),
      ]);
    });
  }
}
