import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_drag_data.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_draggable.dart';
import 'package:flutter/material.dart';

class StatePaletteDragData extends PaletteDragData {
  final bool isInitial;
  final bool isFinal;

  StatePaletteDragData({
    super.type = DiagramTypeEnum.state,
    this.isInitial = false,
    this.isFinal = false,
  });
}

class StatePalette extends StatelessWidget {
  final StatePaletteDragData data;
  final Widget child;
  final Widget feedback;
  final double size;

  const StatePalette({
    super.key,
    required this.data,
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
            data: data,
            feedback: feedback,
            margin: const Offset(stateSize / 2, stateSize / 2),
            child: child,
          ),
        ),
      ),
    );
  }
}
