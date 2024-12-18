import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:fa_simulator/widget/sidebar/palette/palette_drag_data.dart';
import 'package:flutter/material.dart';

class PaletteDraggable extends StatefulWidget {
  final PaletteDragData data;
  final Widget feedback;
  final Widget child;
  final Offset margin;

  const PaletteDraggable({
    super.key,
    required this.data,
    required this.feedback,
    required this.child,
    this.margin = Offset.zero,
  });

  @override
  State<PaletteDraggable> createState() => _PaletteDraggableState();
}

class _PaletteDraggableState extends State<PaletteDraggable> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.data,
      feedback: Container(),
      onDragStarted: () {
        PalleteFeedbackProvider().feedback = widget.feedback;
        PalleteFeedbackProvider().margin = widget.margin;
      },
      onDragUpdate: (details) {
        PalleteFeedbackProvider().position = details.globalPosition;
      },
      child: widget.child,
    );
    
    // GestureDetector(
    //   onPanStart: (details) {
    //     PalleteFeedbackProvider().feedback = widget.feedback;
    //     PalleteFeedbackProvider().margin = widget.margin;
    //   },
    //   onPanUpdate: (details) {
    //     PalleteFeedbackProvider().position = details.globalPosition;
    //   },
    //   onPanEnd: (details) {
    //     if (BodyProvider().isWithinBody(details.globalPosition)) {
    //       widget.onDragEnd(PalleteFeedbackProvider().position! + widget.margin);
    //     }
    //     PalleteFeedbackProvider().reset();
    //   },
    //   child: widget.child,
    // );
  }
}
