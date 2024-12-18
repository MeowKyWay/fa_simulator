import 'package:fa_simulator/widget/sidebar/pallete/state/state_pallete.dart';
import 'package:flutter/material.dart';

class StateWrap extends StatelessWidget {
  const StateWrap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        const StatePallete(),
        Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
        Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
      ],
    );
  }
}
