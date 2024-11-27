import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/provider/new_transition_button_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_feedback_position_provider.dart';
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
        NewTransitionFeedbackPositionProvider().startPosition = widget
                .data.position +
            NewTransitionButtonProvider().position! -
            const Offset(stateSize, stateSize) / 2 -
            const Offset(stateFocusOverlayButtonSize, stateFocusOverlayButtonSize) / 2;
      },
      onDragUpdate: (DragUpdateDetails details) {
        NewTransitionFeedbackPositionProvider().endPosition =
            BodyProvider().getBodyLocalPosition(details.globalPosition);
      },
      onDragEnd: (DraggableDetails details) {
        NewTransitionFeedbackPositionProvider().startPosition = null;
        NewTransitionFeedbackPositionProvider().endPosition = null;
      },
      hitTestBehavior: HitTestBehavior.translucent,
      feedback: IgnorePointer(child: Container()),
      child: widget.child,
    );
  }
}
