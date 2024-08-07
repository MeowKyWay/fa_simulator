import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/widget/diagram/overlay/delete_button.dart';
import 'package:fa_simulator/widget/diagram/overlay/move_button.dart';
import 'package:flutter/material.dart';

class FocusOverlay extends StatelessWidget {
  final Widget child;
  final bool hasFocus;
  final double scale;
  final VoidCallback? onDelete;

  const FocusOverlay({
    super.key,
    required this.child,
    required this.hasFocus,
    required this.scale,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (hasFocus) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: DottedBorder(
              padding: const EdgeInsets.all(0),
              color: focusColor,
              child: child,
            ),
          ),
          if (onDelete != null)
            Positioned(
              top: 0,
              right: 0,
              child: DeleteButton(
                onPressed: onDelete!,
              ),
            ),
        ],
      );
    }
    return child;
  }
}
