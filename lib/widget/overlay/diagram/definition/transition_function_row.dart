import 'package:fa_simulator/widget/components/expand_button.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/transition_function.dart';
import 'package:flutter/material.dart';

class TransitionFunctionRow extends StatefulWidget {
  const TransitionFunctionRow({
    super.key,
  });

  @override
  State<TransitionFunctionRow> createState() => _TransitionFunctionRowState();
}

class _TransitionFunctionRowState extends State<TransitionFunctionRow> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<StateType> states = DiagramList().states;
    states.sort((a, b) => a.label.compareTo(b.label));

    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Listener(
            onPointerDown: (event) {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            // Container to add hitbox to the entire row
            child: Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 26,
                    child: Text(
                      'Transition Function',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Spacer(),
                  ExpandButton(
                    isExpanded: isExpanded,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded) TransitionFunction(),
      ],
    );
  }
}
