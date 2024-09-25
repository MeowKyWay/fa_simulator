import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/create_state_action.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/diagram/state/node/state.dart';
import 'package:fa_simulator/widget/sidebar/pallete/pallete_draggable.dart';
import 'package:flutter/material.dart';

class StatePallete extends StatelessWidget {
  final double size = 50;

  const StatePallete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: PalleteDraggable(
        onDragEnd: onDragEnd,
        feedback: state(),
        margin: const Offset(stateSize / 2, stateSize / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: stateBackgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: stateBorderColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  void onDragEnd(Offset position) {
    AppActionDispatcher().execute(CreateStateAction(position, ''));
  }
}
