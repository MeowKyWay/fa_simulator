import 'dart:developer';

import 'package:fa_simulator/widget/diagram/state/node/accept_state.dart';
import 'package:fa_simulator/widget/diagram/state/node/state.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_drag_data.dart';
import 'package:fa_simulator/widget/sidebar/palette/state/state_palette.dart';
import 'package:flutter/material.dart';
import 'package:fa_simulator/widget/diagram/state/node/start_state.dart';

class StateWrap extends StatelessWidget {
  final double size = 50;

  const StateWrap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Calculate spacing based on available width
      double availableWidth = constraints.maxWidth;
      log(availableWidth.toString());
      double chipWidth = 50; // Approximate width of each chip
      int itemsPerRow = (availableWidth / chipWidth).floor();
      double spacing =
          (availableWidth - itemsPerRow * chipWidth) / (itemsPerRow - 1);
      return Wrap(
        spacing: spacing > 0 ? spacing : 8.0,
        runSpacing: 8.0,
        children: [
          StatePalette(
            type: PaletteDragData.state,
            size: size,
            feedback: state(),
            child: state(stateSize: size),
          ),
          StatePalette(
            type: PaletteDragData.startState,
            size: size,
            feedback: startState(),
            child: startState(stateSize: size),
          ),
          StatePalette(
            type: PaletteDragData.acceptState,
            size: size,
            feedback: acceptState(),
            child: acceptState(stateSize: size),
          ),
        ],
      );
    });
  }
}
