import 'package:flutter/material.dart';

class SimulationResultText extends StatelessWidget {
  const SimulationResultText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Result: ', style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
