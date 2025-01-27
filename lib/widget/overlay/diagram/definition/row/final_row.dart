import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class FinalRow extends StatefulWidget {
  final List<StateType> states;

  const FinalRow({
    super.key,
    required this.states,
  });

  @override
  State<FinalRow> createState() => _FinalRowState();
}

class _FinalRowState extends State<FinalRow> {
  @override
  Widget build(BuildContext context) {
    List<StateType> finalStates =
        widget.states.where((s) => s.isFinal).toList();
    TextStyle? style = Theme.of(context).textTheme.labelMedium;

    String finalStatesLabel = finalStates
        .map((s) => s.label.isEmpty ? 'unnamed state' : s.label)
        .join(', ');
    finalStatesLabel = '{ $finalStatesLabel }';
    finalStatesLabel = finalStates.isEmpty ? '∅' : finalStatesLabel;

    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 26,
                width: 100,
                child: Text(
                  'Initial State',
                  style: style?.red(
                    context,
                    finalStates.isEmpty,
                  ),
                ),
              ),
              Text(
                ": F = ",
                style: style,
              ),
              Tooltip(
                message: finalStates.isEmpty
                    ? 'There must be at least one final state.'
                    : '',
                child: Text(
                  finalStatesLabel,
                  style: style?.red(
                    context,
                    finalStates.isEmpty,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
