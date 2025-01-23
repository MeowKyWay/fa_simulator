import 'package:fa_simulator/compiler/state_compiler.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/expand_button.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/state_table.dart';
import 'package:flutter/material.dart';

class StatesRow extends StatefulWidget {
  final List<StateType> states;
  final Map<String, List<StateErrorType>> errors;

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
                    width: 75,
                    child: Text(
                      'States',
                      style: style,
                    ),
                  ),
                  Text(
                    ": Q = { ",
                    style: style,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: style,
                        children: [
                          ...List.generate(
                            widget.states.length,
                            (index) {
                              StateType state = widget.states[index];
                              bool shouldAddComma =
                                  index + 1 != widget.states.length;
                              List<StateErrorType>? error =
                                  widget.errors[state.id];
                              String label = error?.contains(
                                          StateErrorType.unnamedState) ??
                                      false
                                  ? 'unnamed state'
                                  : state.label;
                              return TextSpan(
                                children: [
                                  TextSpan(
                                    text: label,
                                    style: style?.red(
                                      context,
                                      error?.isNotEmpty ?? false,
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
                    ),
                    // child: Text(
                    //   '${states.map((s) => s.label == "" ? "unnamed state" : s.label).join(', ')} }',
                    //   style: Theme.of(context).textTheme.labelMedium,
                    //   softWrap: true,
                    // ),
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
}
