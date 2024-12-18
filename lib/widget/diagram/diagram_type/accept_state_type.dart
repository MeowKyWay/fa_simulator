import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class AcceptStateType extends StateType {
  AcceptStateType({
    required super.id,
    required super.position,
    required super.label,
    super.hasFocus,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'accept_state',
      'id': id,
      'label': label,
      'position': {
        'dx': position.dx,
        'dy': position.dy,
      },
    };
  }
}
