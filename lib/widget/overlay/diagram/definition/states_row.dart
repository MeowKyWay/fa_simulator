import 'package:fa_simulator/widget/components/expand_button.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/state_table.dart';
import 'package:flutter/material.dart';

class StatesRow extends StatefulWidget {
  const StatesRow({
    super.key,
  });

  @override
  State<StatesRow> createState() => _StatesRowState();
}

class _StatesRowState extends State<StatesRow> {
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
                    width: 75,
                    child: Text(
                      'States',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Text(
                    ": Q = { ",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Expanded(
                    child: Text(
                      '${states.map((s) => s.label == "" ? "unnamed state" : s.label).join(', ')} }',
                      style: Theme.of(context).textTheme.labelMedium,
                      softWrap: true,
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
        if (isExpanded) StateTable(states: states),
      ],
    );
  }
}
