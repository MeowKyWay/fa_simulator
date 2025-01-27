import 'package:fa_simulator/compiler/diagram_error_list.dart';
import 'package:fa_simulator/compiler/error/state_error.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/expand_button.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/state_table.dart';
import 'package:flutter/material.dart';

class StatesRow extends StatefulWidget {
  final List<StateType> states;
  final DiagramErrorList errors;

  const StatesRow({
    super.key,
    required this.states,
    required this.errors,
  });

  @override
  State<StatesRow> createState() => _StatesRowState();
}

class _StatesRowState extends State<StatesRow> {
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
                    width: 100,
                    child: Text(
                      'States',
                      style: style?.red(
                        context,
                        widget.errors.stateErrors.isNotEmpty,
                      ),
                    ),
                  ),
                  Text(
                    ": Q = { ",
                    style: style,
                  ),
                  Expanded(
                    child: _buildStatesLabel(widget.states, style),
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
          StateTable(
            states: widget.states,
            errors: widget.errors,
          ),
      ],
    );
  }

  Widget _buildStatesLabel(List<StateType> states, TextStyle? style) {
    return RichText(
      text: TextSpan(
        style: style,
        children: [
          ...List.generate(
            widget.states.length,
            (index) {
              StateType state = widget.states[index];
              bool shouldAddComma = index + 1 != widget.states.length;
              StateErrors? error = widget.errors.stateError(state.id);

              // Error
              bool isUnnamed = error?.isUnnamed != null;

              String label = isUnnamed ? 'unnamed state' : state.label;
              return TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: style?.red(
                      context,
                      error != null,
                    ),
                  ),
                  TextSpan(
                    text: shouldAddComma ? ', ' : '',
                  ),
                ],
              );
            },
          ),
          TextSpan(
            text: ' }',
          )
        ],
      ),
    );
  }
}
