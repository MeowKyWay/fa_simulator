import 'dart:developer';

import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:flutter/material.dart';

class DiagramDraggable extends StatefulWidget {
  final Widget child;

  const DiagramDraggable({
    super.key,
    required this.child,
  });

  @override
  State<DiagramDraggable> createState() {
    return _DiagramDraggableState();
  }
}

class _DiagramDraggableState extends State<DiagramDraggable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DraggingDiagramType data = DraggingDiagramType();

    return Draggable(
      data: data,
      onDragStarted: () {
        DiagramDraggingProvider().calculateOffset();
      },
      onDragUpdate: (details) {
        if (DiagramDraggingProvider().firstMoveFlag) {
          DiagramDraggingProvider().firstMoveFlag = false;
          DiagramDraggingProvider().startPosition =
              BodyProvider().getBodyLocalPosition(details.globalPosition);
        }
        DiagramDraggingProvider().endPosition =
            BodyProvider().getBodyLocalPosition(details.globalPosition);
      },
      onDragEnd: (details) {
        DiagramDraggingProvider().reset();
      },
      feedback: Container(),
      child: widget.child,
    );
  }
}
