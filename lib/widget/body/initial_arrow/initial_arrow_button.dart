import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/move_state_initial_arrow_action.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/start_arrow_feedback_provider.dart';
import 'package:fa_simulator/widget/utility/offset_util.dart';
import 'package:flutter/material.dart';

class StartArrowButton extends StatefulWidget {
  final StateType state;

  const StartArrowButton({
    super.key,
    required this.state,
  });

  @override
  State<StartArrowButton> createState() => _StartArrowButtonState();
}

class _StartArrowButtonState extends State<StartArrowButton> {
  bool _isHovered = false;
  double _dragAngle = 0;

  @override
  Widget build(BuildContext context) {
    double buttonSize = 15;

    Offset position = calculateNewPoint(
      widget.state.position,
      stateSize / 2 + startArrowLength,
      widget.state.initialArrowAngle,
    );

    return Positioned(
      left: position.dx - buttonSize / 2,
      top: position.dy - buttonSize / 2,
      child: ClipOval(
        //Drag to change the transition start center or end point
        child: Draggable(
          onDragStarted: () {
            StartArrowFeedbackProvider().id = widget.state.id;
          },
          onDragUpdate: (details) {
            Offset bodyPosition = BodyProvider().getBodyLocalPosition(
              details.globalPosition,
            );
            _dragAngle = (bodyPosition - widget.state.position).direction;
            StartArrowFeedbackProvider().angle = _dragAngle;
          },
          onDragEnd: (details) {
            AppActionDispatcher().execute(
              MoveStateInitialArrowAction(
                id: widget.state.id,
                angle: _dragAngle,
              ),
            );
            StartArrowFeedbackProvider().reset();
          },
          feedback: Container(),
          child: MouseRegion(
            onEnter: (event) {
              setState(() {
                _isHovered = true;
              });
            },
            onExit: (event) {
              setState(() {
                _isHovered = false;
              });
            },
            cursor: SystemMouseCursors.grab,
            child: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: _isHovered
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).focusColor,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1,
                      ),
                    )
                  : const BoxDecoration(),
            ),
          ),
        ),
      ),
    );
  }
}
