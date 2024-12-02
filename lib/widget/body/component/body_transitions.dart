import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/transition/diagram_transition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyTransitions extends StatelessWidget {
  const BodyTransitions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, diagramList, child) {
      return Stack(children: [
        ...diagramList.transitions.map((transition) {
          return DiagramTransition(
            transition: transition,
          );
        }),
      ]);
    });
  }
}
