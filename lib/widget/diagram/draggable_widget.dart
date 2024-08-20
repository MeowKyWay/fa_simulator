import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/widget/body/body.dart';
import 'package:flutter/material.dart';

class DraggableState extends StatefulWidget {
  final Offset margin;
  final Widget child;
  final Widget feedback;
  final Function(Offset) onDragEnd;
  final double scale;
  final bool hasFocus;
  final Function requestFocus;

  const DraggableState({
    super.key,
    this.margin = const Offset(0, 0),
    required this.child,
    required this.onDragEnd,
    required this.hasFocus,
    required this.requestFocus,
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
  State<DraggableState> createState() {
    return _DraggableStateState();
  }
}

class _DraggableStateState extends State<DraggableState> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Draggable(
        feedback: Transform.scale(
          scale: widget.scale,
          alignment: Alignment.topLeft,
          child: widget.feedback,
        ),
        dragAnchorStrategy: (draggable, context, position) {
          final RenderBox renderObject = context.findRenderObject()! as RenderBox;
          final localPosition =
              renderObject.globalToLocal(position) + widget.margin;
          return (localPosition) -
              Offset(stateSize * localPosition.dx, stateSize * localPosition.dy) *
                  (1 - scale) /
                  100;
        },
        onDragStarted: () {
          FocusScope.of(context).unfocus();
        },
        onDragEnd: (details) {
          Offset newPosition = details.offset;
          widget.onDragEnd(newPosition);
          widget.requestFocus();
        },
        childWhenDragging: Container(),
        child: widget.child,
      ),
    );
  }
}
