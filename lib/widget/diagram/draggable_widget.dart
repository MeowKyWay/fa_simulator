import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Offset position;
  final Offset margin;
  final Widget child;
  final Widget feedback;
  final Function(Offset) onDragEnd;
  final double scale;

  const DraggableWidget({
    super.key,
    required this.position,
    this.margin = const Offset(0, 0),
    required this.child,
    required this.onDragEnd,
    this.scale = 1.0,
    this.feedback = const SizedBox(
      height: 50,
      width: 50,
      child: Icon(
        Icons.add,
        color: Colors.blue,
      ),
    ),
  });

  @override
  State<DraggableWidget> createState() {
    return _DraggableWidgetState();
  }
}

class _DraggableWidgetState extends State<DraggableWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx + widget.margin.dx,
      top: widget.position.dy + widget.margin.dy,
      child: Draggable(
        feedback: Transform.scale(
          scale: widget.scale,
          alignment: Alignment.center,
          child: widget.feedback,
        ),
        dragAnchorStrategy: (draggable, context, position) {
          return Offset.zero - widget.margin;
        },
        onDragEnd: (details) {
          Offset newPosition = details.offset;
          widget.onDragEnd(newPosition - widget.margin);
        },
        child: widget.child,
      ),
    );
  }
}
