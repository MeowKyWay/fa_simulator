import 'dart:developer';

import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:flutter/material.dart';

class NewTransitionDraggable extends StatefulWidget {

  final Widget child;

  const NewTransitionDraggable({
    super.key,
    required this.child,
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
    Offset startPosition = Offset.zero;

    bool firstMoveFlag = true;

    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        log('onPanStart');
        startPosition = BodySingleton().getBodyLocalPosition(details.globalPosition);
        log('startPosition: $startPosition');
      },child: widget.child,
      onPanUpdate: (DragUpdateDetails details) {
        log('onPanUpdate');
        Offset position = BodySingleton().getBodyLocalPosition(details.globalPosition);
        log('position: $position');
      }
    );
  }
}
