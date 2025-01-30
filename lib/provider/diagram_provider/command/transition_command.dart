import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:flutter/material.dart';

class AddTransitionCommand extends DiagramCommand {
  final TransitionType transition;

  const AddTransitionCommand({
    required this.transition,
  });
}

class UpdateTransitionCommand extends DiagramCommand {
  final TransitionDetail detail;

  const UpdateTransitionCommand({
    required this.detail,
  });
}

class DeleteTransitionCommand extends DiagramCommand {
  final String id;

  const DeleteTransitionCommand({
    required this.id,
  });
}

class MoveTransitionCommand extends DiagramCommand {
  final String id;
  final TransitionPivotType pivotType;
  final Offset? distance;
  final Offset? position;

  const MoveTransitionCommand({
    required this.id,
    required this.pivotType,
    this.distance,
    this.position,
  }) : assert(!(distance != null && position != null));
}

class AttachTransitionCommand extends DiagramCommand {
  final String id;
  final TransitionEndPointType pivotType;
  final String stateId;

  const AttachTransitionCommand({
    required this.id,
    required this.pivotType,
    required this.stateId,
  });
}
