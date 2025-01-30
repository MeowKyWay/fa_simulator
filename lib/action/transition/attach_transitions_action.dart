import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/transition_command.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:flutter/material.dart';

//Only work one transition at a time
class AttachTransitionAction extends AppAction {
  final String id;
  final TransitionEndPointType endPoint;
  final String stateId;
  final bool? isCentered;
  final double? angle;
  String? oldStateId;
  Offset? oldPosition;

  AttachTransitionAction({
    required this.id,
    required this.endPoint,
    required this.stateId,
    this.isCentered,
    this.angle,
  }) : super() {
    if (isCentered == null && angle == null) {
      throw ArgumentError(
          'Either provide isCentered or angle to attach a transition to a state');
    }
  }

  @override
  bool get isRevertable => true;

  @override
  Future<void> execute() async {
    TransitionType transition = DiagramList().transition(id);
    if (endPoint == TransitionEndPointType.start) {
      if (transition.sourceState != null) {
        oldStateId = transition.sourceState!.id;
      } else if (transition.sourcePosition != null) {
        oldPosition = transition.sourcePosition!;
      } else {
        throw StateError('Transition has no both source state and position');
      }
    } else {
      if (transition.destinationState != null) {
        oldStateId = transition.destinationState!.id;
      } else if (transition.destinationPosition != null) {
        oldPosition = transition.destinationPosition!;
      } else {
        throw StateError(
            'Transition has no both destination state and position');
      }
    }
    DiagramList().executeCommand(
      AttachTransitionCommand(id: id, pivotType: endPoint, stateId: stateId),
    );
    FocusProvider().requestFocus(id);
  }

  @override
  Future<void> undo() async {
    if (oldStateId != null) {
      DiagramList().executeCommand(
        AttachTransitionCommand(
          id: id,
          stateId: oldStateId!,
          pivotType: endPoint,
        ),
      );
    } else if (oldPosition != null) {
      DiagramList().executeCommand(
        MoveTransitionCommand(
          id: id,
          pivotType: endPoint.pivotType,
          position: oldPosition,
        ),
      );
    }
    FocusProvider().requestFocus(id);
  }

  @override
  Future<void> redo() async {
    execute();
  }
}
