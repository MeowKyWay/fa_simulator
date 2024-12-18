import 'package:fa_simulator/widget/sidebar/palette/state/state_palette.dart';
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
        const StatePalette(),
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
