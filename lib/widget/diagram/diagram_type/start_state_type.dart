
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class StartStateType extends StateType {
  StartStateType({
    required super.id,
    required super.position,
    required super.label,
    super.hasFocus,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'start_state',
      'id': id,
      'label': label,
      'position': {
        'dx': position.dx,
        'dy': position.dy,
      },
    };
  }

  factory StartStateType.fromJson(Map<String, dynamic> json) {
    return StartStateType(
      id: json['id'],
      label: json['label'],
      position: Offset(
        json['position']['dx'],
        json['position']['dy'],
      ),
    );
  }
}
