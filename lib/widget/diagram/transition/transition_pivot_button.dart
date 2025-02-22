import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:flutter/material.dart';

class TransitionPivotButton extends StatefulWidget {
  final Offset position;
  final Offset offset;
  final bool hasFocus;

  final TransitionType transition;
  final TransitionPivotType type;

  const TransitionPivotButton({
    super.key,
    required this.position,
    this.offset = Offset.zero,
    this.hasFocus = false,
    required this.transition,
    required this.type,
  });

  @override
  State<TransitionPivotButton> createState() => _TransitionPivotButtonState();
}

class _TransitionPivotButtonState extends State<TransitionPivotButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    double buttonSize = 15;

    DraggingTransitionType data;

    data = DraggingTransitionType(
      transition: widget.transition,
      draggingPivot: widget.type,
    );

    return Positioned(
      left: widget.position.dx - buttonSize / 2,
      top: widget.position.dy - buttonSize / 2,
      child: ClipOval(
        //Drag to change the transition start center or end point
        child: Draggable(
          data: data,
          onDragStarted: () {
            TransitionDraggingProvider().startPosition = widget.position;
            TransitionDraggingProvider().draggingItemId = widget.transition.id;
            TransitionDraggingProvider().pivotType = widget.type;
          },
          onDragUpdate: (details) {
            TransitionDraggingProvider().endPosition =
                BodyProvider().getBodyLocalPosition(details.globalPosition);
          },
          onDragCompleted: () {
            TransitionDraggingProvider().reset();
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
                decoration: _isHovered || widget.hasFocus
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).focusColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                        ),
                      )
                    : const BoxDecoration(),
              )),
        ),
      ),
    );
  }
}
