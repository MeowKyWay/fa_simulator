import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/widget/diagram/delete_button.dart';
import 'package:flutter/material.dart';

class FocusOverlay extends StatelessWidget {
  final Widget child;
  final bool hasFocus;
  final VoidCallback? onDelete;

  const FocusOverlay(
      {super.key, required this.child, required this.hasFocus, this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (hasFocus) {
      return Stack(clipBehavior: Clip.none, children: [
        DottedBorder(
          padding: const EdgeInsets.all(0),
          child: child,
        ),
        if (onDelete != null)
          Positioned(
            top: -7.5,
            right: -7.5,
            child: DeleteButton(
              onPressed: onDelete!,
            ),
          ),
      ]);
    }
    return child;
  }
}
