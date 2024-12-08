import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/transition_manager.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_type.dart';
import 'package:flutter/material.dart';

//Only work one transition at a time
class AttachTransitionAction extends AppAction {
  final String id;
  final TransitionEndPointType endPoint;
  final String stateId;
  final bool? isCentered;
  final double? angle;
  late Offset oldPosition;

  AttachTransitionAction({
    required this.id,
    required this.endPoint,
    required this.stateId,
    this.isCentered,
    this.angle,
  }) : super() {
    if (isCentered == null && angle == null) {
      throw ArgumentError(
          "Either provide isCentered or angle to attach a transition to a state");
    }
  }

  @override
  bool get isRevertable => true;

  @override
  void execute() {
    TransitionType transition = DiagramList().transition(id);
    oldPosition = endPoint == TransitionEndPointType.start
        ? transition.sourcePosition!
        : transition.destinationPosition!;
    attachTransition(
      id: id,
      endPoint: endPoint,
      stateId: stateId,
    );
  }

  @override
  void undo() {
    TransitionType transition = DiagramList().transition(id);
    switch (endPoint) {
      case TransitionEndPointType.start:
        transition.sourcePosition = oldPosition;
        transition.resetSourceState();
        break;
      case TransitionEndPointType.end:
        transition.destinationPosition = oldPosition;
        transition.resetDestinationState();
        break;
    }
    DiagramList().notify();
  }

  @override
  void redo() {
    execute();
  }
}
