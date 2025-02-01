import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class InitialRow extends StatefulWidget {
  final List<StateType> states;

  const InitialRow({
    super.key,
    required this.states,
  });

  @override
  State<InitialRow> createState() => _InitialRowState();
}

class _InitialRowState extends State<InitialRow> {
  @override
  Widget build(BuildContext context) {
    List<StateType> initialStates =
        widget.states.where((s) => s.isInitial).toList();
    TextStyle? style = Theme.of(context).textTheme.labelMedium;

    String initialStatesLabel = initialStates
        .map((s) => s.label.isEmpty ? 'unnamed state' : s.label)
        .join(', ');
    initialStatesLabel = initialStates.isEmpty ? '∅' : initialStatesLabel;
    initialStatesLabel = initialStates.length > 1
        ? '{ $initialStatesLabel }'
        : initialStatesLabel;

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
                    initialStates.length != 1,
                  ),
                ),
              ),
              Text(
                ': q\u2080 = ',
                style: style,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 650,
                ),
                child: Text(
                  initialStatesLabel,
                  style: style,
                ),
              ),
              Text(
                initialStates.isEmpty
                    ? '  (No initial states)'
                    : initialStates.length > 1
                        ? '  (Multiple initial states)'
                        : '',
                style: style?.red(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
