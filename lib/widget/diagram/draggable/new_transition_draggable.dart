import 'dart:developer';

import 'package:fa_simulator/widget/diagram/diagram_type.dart';
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
        log("Drag started");
      },
      feedback: Container(),
      child: widget.child,
    );
  }
}
