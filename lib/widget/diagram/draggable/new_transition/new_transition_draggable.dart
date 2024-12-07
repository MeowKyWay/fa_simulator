import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class NewTransitionType {
  final StateType from;

  const NewTransitionType({
    required this.from,
  });
}

class NewTransitionDraggable extends StatefulWidget {
  final Widget child;
  final StateType state;

  const NewTransitionDraggable({
    super.key,
    required this.child,
    required this.state,
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
    NewTransitionType newTransition = NewTransitionType(
      from: widget.state,
    );

    return Draggable(
      data: newTransition,
      onDragStarted: () {
        NewTransitionProvider().sourceState = widget.state;
        NewTransitionProvider().isDraggingNewTransition = true;
      },
      onDragUpdate: (DragUpdateDetails details) {
        NewTransitionProvider().draggingPosition =
            BodyProvider().getBodyLocalPosition(details.globalPosition);
      },
      onDragEnd: (DraggableDetails details) {
        NewTransitionProvider().reset();
      },
      feedback: IgnorePointer(child: Container()),
      child: widget.child,
    );
  }
}
