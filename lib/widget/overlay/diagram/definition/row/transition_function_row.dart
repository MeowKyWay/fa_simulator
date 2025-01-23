import 'package:fa_simulator/compiler/alphabet_compiler.dart';
import 'package:fa_simulator/compiler/state_compiler.dart';
import 'package:fa_simulator/compiler/transition_function_compiler.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/expand_button.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/transition_function.dart';
import 'package:flutter/material.dart';

class TransitionFunctionRow extends StatefulWidget {
  final TransitionFunctionType transitionFunction;

  final Map<String, List<StateErrorType>> stateErrors;
  final Map<String, List<AlphabetErrorType>> alphabetErrors;
  final Map<TransitionFunctionKey, List<TransitionFunctionErrorType>>
      transitionErrors;

  const TransitionFunctionRow({
    super.key,
    required this.transitionFunction,
    required this.stateErrors,
    required this.alphabetErrors,
    required this.transitionErrors,
  });

  @override
  State<TransitionFunctionRow> createState() => _TransitionFunctionRowState();
}

class _TransitionFunctionRowState extends State<TransitionFunctionRow> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool isError = false;
    if (widget.transitionErrors.isNotEmpty) {
      isError = true;
    }

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
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.red(context, isError),
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
          TransitionFunction(
            transitionFunction: widget.transitionFunction,
            stateErrors: widget.stateErrors,
            alphabetErrors: widget.alphabetErrors,
            transitionErrors: widget.transitionErrors,
          ),
      ],
    );
  }
}
