import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:flutter/material.dart';

class StateHoverOverlayDragTarget extends StatelessWidget {
  final Widget child;
  final StateType state;

  const StateHoverOverlayDragTarget({
    super.key,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAcceptWithDetails: (DragTargetDetails details) {
        if (details.data is NewTransitionType) {
          if ((details.data as NewTransitionType).from.id == state.id) {
            return false;
          }
          return true;
        }
        return false;
      },
      onAcceptWithDetails: (details) {
        StateType state = (details.data as NewTransitionType).from;
      },
      onLeave: (details) {},
      hitTestBehavior: HitTestBehavior.translucent,
      builder: (context, candidateData, rejectedData) => child,
    );
  }
}
