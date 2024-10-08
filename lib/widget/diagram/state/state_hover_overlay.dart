import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class StateHoverOverlay extends StatelessWidget {
  final bool isHovered;

  const StateHoverOverlay({
    super.key,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    if (!isHovered) {
      return Container();
    }
    return IgnorePointer(
      child: DottedBorder(
        dashPattern: const [5, 5],
        color: focusColor,
        borderType: BorderType.Circle,
        padding: const EdgeInsets.all(0),
        child: const SizedBox(
          width: stateSize,
          height: stateSize,
        ),
      ),
    );
  }
}
