import 'dart:developer';

import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition_feedback_position_provider.dart';
import 'package:flutter/material.dart';

class NewTransitionDraggable extends StatefulWidget {

  final Widget child;
  final StateType data;

  const NewTransitionDraggable({
    super.key,
    required this.child,
    required this.data,
  });

  @override
  State<NewTransitionDraggable> createState() {
    return _NewTransitionDraggableState();
  }
}

class _NewTransitionDraggableState extends State<NewTransitionDraggable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.data,
      onDragStarted: () {
        NewTransitionFeedbackPositionProvider().startPosition = widget.data.position;
      },
      onDragUpdate: (DragUpdateDetails details) {
        NewTransitionFeedbackPositionProvider().endPosition = BodySingleton().getBodyLocalPosition(details.globalPosition);
      },
      onDragEnd: (DraggableDetails details) {
        NewTransitionFeedbackPositionProvider().startPosition = null;
        NewTransitionFeedbackPositionProvider().endPosition = null;
      },
      feedback: Container(),
      child: widget.child,
    );
  }
}
