import 'package:fa_simulator/provider/diagram_provider/command/diagram_command.dart';
import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class AddStateCommand extends DiagramCommand {
  final StateType state;

  const AddStateCommand({
    required this.state,
  });
}

class UpdateStateCommand extends DiagramCommand {
  final StateDetail detail;

  const UpdateStateCommand({
    required this.detail,
  });
}

class DeleteStateCommand extends DiagramCommand {
  final String id;

  const DeleteStateCommand({
    required this.id,
  });
}

class MoveStateCommand extends DiagramCommand {
  final String id;
  final Offset? distance;
  final Offset? position;

  const MoveStateCommand({
    required this.id,
    this.distance,
    this.position,
  }) : assert(!(distance != null && position != null));
}
