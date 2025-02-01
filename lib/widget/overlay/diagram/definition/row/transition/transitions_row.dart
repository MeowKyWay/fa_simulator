import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/expand_button.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/transition/transition_table.dart';
import 'package:flutter/material.dart';

class TransitionsRow extends StatefulWidget {
  final List<TransitionType> transitions;
  final DiagramErrorList errors;

  const TransitionsRow({
    super.key,
    required this.transitions,
    required this.errors,
  });

  @override
  State<TransitionsRow> createState() => _TransitionsRowState();
}

class _TransitionsRowState extends State<TransitionsRow> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.labelMedium;

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
                      'Transitions',
                      style: style?.red(
                        context,
                        widget.errors.hasTransitionError,
                      ),
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
        if (isExpanded)
          TransitionTable(
            transitions: widget.transitions,
            errors: widget.errors,
          ),
      ],
    );
  }
}
