import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/diagram/state/node/state.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_drag_data.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_draggable.dart';
import 'package:flutter/material.dart';

class StatePalette extends StatelessWidget {
  final double size = 50;

  const StatePalette({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: PaletteDraggable(
        data: PaletteDragData.state,
        feedback: state(),
        margin: const Offset(stateSize / 2, stateSize / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: stateBackgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: stateBorderColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
