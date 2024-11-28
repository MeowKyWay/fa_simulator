
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_button.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyNewTransitionButton extends StatelessWidget {
  const BodyNewTransitionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTransitionProvider>(builder: (context, provider, child) {
      Offset? position;
      position = provider.position;
      return position != null
          ? NewTransitionButton(position: position)
          : Container();
    });
  }
}
