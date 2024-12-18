import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_drag_data.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_draggable.dart';
import 'package:flutter/material.dart';

class StatePalette extends StatelessWidget {
  final PaletteDragData type;
  final Widget child;
  final Widget feedback;
  final double size;

  const StatePalette({
    super.key,
    required this.type,
    required this.child,
    required this.feedback,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Center(
        child: ClipOval(
          child: PaletteDraggable(
            data: type,
            feedback: feedback,
            margin: const Offset(stateSize / 2, stateSize / 2),
            child: child,
          ),
        ),
      ),
    );
  }
}
