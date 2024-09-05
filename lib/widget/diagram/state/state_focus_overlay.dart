import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class StateFocusOverlay extends StatelessWidget {
  const StateFocusOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        padding: const EdgeInsets.all(0.5),
        borderType: BorderType.Oval,
        dashPattern: const [5, 2.5],
        strokeWidth: 2,
        color: focusColor,
        child: Container());
  }
}
