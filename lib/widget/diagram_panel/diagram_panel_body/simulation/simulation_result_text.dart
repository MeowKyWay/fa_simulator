import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SimulationResultText extends StatelessWidget {
  final Tuple2<bool, List<Tuple2<StateType, String>>>? result;

  const SimulationResultText({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    String path = '';
    if (result?.item2 != null && result!.item2.isNotEmpty) {
      path += result!.item2.first.item1.label;
      for (Tuple2<StateType, String> e in result!.item2) {
        if (e == result!.item2.first) {
          continue;
        }
        path += ' --${e.item2}-> ';
        path += e.item1.label;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (result != null) ...[
          Row(
            children: [
              Text('Result: ', style: Theme.of(context).textTheme.labelSmall),
              Text(
                result?.item1 == true ? 'Accepted' : 'Rejected',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          if (result!.item1)
            Row(
              children: [
                Text('Path: ', style: Theme.of(context).textTheme.labelSmall),
                Text(
                  path,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            )
        ]
      ],
    );
  }
}
