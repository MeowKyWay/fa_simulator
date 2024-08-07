import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/widget/diagram/overlay/delete_button.dart';
import 'package:fa_simulator/widget/diagram/overlay/move_button.dart';
import 'package:flutter/material.dart';

class FocusOverlay extends StatelessWidget {
  final Widget child;
  final bool hasFocus;
  final double scale;
  final Widget feedback;
  final VoidCallback? onDelete;
  final Function(Offset)? onDragEnd;

  const FocusOverlay({
    super.key,
    required this.child,
    required this.hasFocus,
    required this.scale,
    required this.feedback,
    this.onDelete,
    this.onDragEnd,
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
          if (onDragEnd != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: MoveButton(
                onDragEnd: onDragEnd!,
                feedback: feedback,
                scale: scale,
              ),
            ),
        ],
      );
    }
    return child;
  }
}
