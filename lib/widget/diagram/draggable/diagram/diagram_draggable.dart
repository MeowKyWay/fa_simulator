import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/move_states_action.dart';
import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/feedback_position_provider.dart';
import 'package:flutter/material.dart';

class DiagramDraggable extends StatefulWidget {
  const DiagramDraggable({
    super.key,
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
    Offset startPosition = Offset.zero;

    bool firstMoveFlag = true;

    return GestureDetector(
      onPanStart: (details) {
        startPosition = details.localPosition;
      },
      onPanUpdate: (details) {
        if (firstMoveFlag) {
          FeedbackPositionProvider().size =
              BodySingleton().getDraggableOverlaySize();
          FeedbackPositionProvider().startPosition =
              BodySingleton().getDraggableOverlayPosition();
        }
        Offset delta = details.localPosition - startPosition;
        FeedbackPositionProvider().updatePosition(delta);
      },
      onPanEnd: (details) {
        firstMoveFlag = true;
        FeedbackPositionProvider().reset();
        AppActionDispatcher().execute(MoveStatesAction(
          //TODO implement move transition
          DiagramList().focusedStates.map((state) => state.id).toList(),
          details.localPosition - startPosition,
        ));
      },
      child: Container(
        color: Colors.transparent,
      ),
    );
  }
}
