import 'dart:math';

import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class StartStateType extends StateType {
  double initialTransitionAngle;

  StartStateType({
    required super.id,
    required super.position,
    required super.label,
    super.hasFocus,
    this.initialTransitionAngle = pi / 4,
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
      'initialTransitionAngle': initialTransitionAngle,
    };
  }
}
