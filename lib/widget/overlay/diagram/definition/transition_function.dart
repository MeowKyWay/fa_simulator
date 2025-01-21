import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class TransitionFunction extends StatelessWidget {
  const TransitionFunction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    List<StateType> states = DiagramList().states;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'δ :',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}