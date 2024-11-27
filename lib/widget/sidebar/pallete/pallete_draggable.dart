
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:flutter/material.dart';

class PalleteDraggable extends StatefulWidget {
  final Function(Offset) onDragEnd;
  final Widget feedback;
  final Widget child;
  final Offset margin;

  const PalleteDraggable({
    super.key,
    required this.onDragEnd,
    required this.feedback,
    required this.child,
    this.margin = Offset.zero,
  });

  @override
  State<PalleteDraggable> createState() => _PalleteDraggableState();
}

class _PalleteDraggableState extends State<PalleteDraggable> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        PalleteFeedbackProvider().feedback = widget.feedback;
        PalleteFeedbackProvider().margin = widget.margin;
      },
      onPanUpdate: (details) {
        PalleteFeedbackProvider().position = details.globalPosition;
      },
      onPanEnd: (details) {
        if (BodyProvider().isWithinBody(details.globalPosition)) {
          widget.onDragEnd(PalleteFeedbackProvider().position! + widget.margin);
        }
        PalleteFeedbackProvider().reset();
      },
      child: widget.child,
    );
  }
}
