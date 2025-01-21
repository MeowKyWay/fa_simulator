import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:flutter/material.dart';

class TransitionFunction extends StatelessWidget {
  const TransitionFunction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TransitionFunctionType transitionFunction =
        DiagramList().transitionFunction;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'δ :',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var entry in transitionFunction.entries)
                Builder(
                  builder: (context) {
                    String sourceStateLabel = entry.key.sourceStateLabel;
                    String destinationStateLabel = entry.value.destinationStateLabel;
                    String symbol = entry.key.symbol;
                    if (sourceStateLabel.isEmpty) {
                      sourceStateLabel = 'unnamed state';
                    }
                    if (destinationStateLabel.isEmpty) {
                      destinationStateLabel = 'unnamed state';
                    }
                    return Text(
                      ' • δ($sourceStateLabel, $symbol) = $destinationStateLabel',
                      style: Theme.of(context).textTheme.labelMedium,
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
