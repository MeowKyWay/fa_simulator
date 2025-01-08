import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class FocusOverlay extends StatelessWidget {
  final Offset position;

  const FocusOverlay({
    super.key,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - (stateSize / 2),
      top: position.dy - (stateSize / 2),
      child: IgnorePointer(
        child: DottedBorder(
          padding: EdgeInsets.zero,
          color: Theme.of(context).focusColor,
          dashPattern: const [5, 2.5],
          child: const SizedBox(
            width: stateSize,
            height: stateSize,
          ),
        ),
      ),
    );
  }
}
