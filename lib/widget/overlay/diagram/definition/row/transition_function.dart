import 'dart:developer';

import 'package:fa_simulator/compiler/alphabet_compiler.dart';
import 'package:fa_simulator/compiler/state_compiler.dart';
import 'package:fa_simulator/compiler/transition_function_compiler.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:flutter/material.dart';

class TransitionFunction extends StatelessWidget {
  final TransitionFunctionType transitionFunction;
  final Map<String, List<StateErrorType>> stateErrors;
  final Map<String, List<AlphabetErrorType>> alphabetErrors;
  final Map<TransitionFunctionKey, List<TransitionFunctionErrorType>>
      transitionErrors;

  const TransitionFunction({
    super.key,
    required this.transitionFunction,
    required this.stateErrors,
    required this.alphabetErrors,
    required this.transitionErrors,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.labelMedium;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'δ :',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var entry in transitionFunction.entries)
                Builder(
                  builder: (context) {
                    List<TransitionFunctionErrorType>? transitionError =
                        transitionErrors[entry.key];

                    bool isUnnamedSourceState =
                        stateErrors[entry.key.sourceStateId]
                                ?.contains(StateErrorType.unnamedState) ??
                            false;
                    bool isUnregisteredAlphabet =
                        alphabetErrors[entry.key.symbol]?.contains(
                                AlphabetErrorType.unregisteredSymbol) ??
                            false;
                    bool isMultipleDestinationStates =
                        transitionError?.contains(TransitionFunctionErrorType
                                .multipleDestinationStates) ??
                            false;

                    log(isUnnamedSourceState.toString());

                    String sourceStateLabel = entry.key.sourceStateLabel;
                    List<String> destinationStateLabels =
                        entry.value.destinationStateLabels;

                    bool hasMultipleDestination =
                        destinationStateLabels.length > 1;

                    String symbol = entry.key.symbol;
                    if (isUnnamedSourceState) {
                      sourceStateLabel = 'unnamed state';
                    }

                    String value = destinationStateLabels
                        .map((e) => e.isEmpty ? 'unnamed state' : e)
                        .join(', ');

                    value = destinationStateLabels.length == 1
                        ? value
                        : '{ $value }';

                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: ' • δ( ',
                            style: style,
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: Tooltip(
                              message: isUnnamedSourceState
                                  ? 'Unnamed state: The state with ID “${entry.key.sourceStateId}” does not have a name.'
                                  : '',
                              child: Text(
                                sourceStateLabel,
                                style:
                                    style?.red(context, isUnnamedSourceState),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: ', ',
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: Tooltip(
                              message:
                                  'The symbol $symbol was not found in the alphabet.',
                              child: Text(
                                symbol,
                                style:
                                    style?.red(context, isUnregisteredAlphabet),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: ' ) = ',
                            style: style,
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: Tooltip(
                              message: isMultipleDestinationStates
                                  ? 'A DFA does not allow multiple destination states for the same state and symbol.'
                                  : '',
                              child: RichText(
                                text: TextSpan(
                                  style: style?.red(
                                      context, isMultipleDestinationStates),
                                  children: [
                                    TextSpan(
                                      text: hasMultipleDestination ? '{ ' : '',
                                    ),
                                    ...List.generate(
                                        destinationStateLabels.length, (index) {
                                      String label =
                                          destinationStateLabels[index];
                                      label = label.isEmpty
                                          ? 'unnamed state'
                                          : label;
                                      bool shouldAddComma = index + 1 !=
                                          destinationStateLabels.length;
                                      return TextSpan(children: [
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.baseline,
                                          baseline: TextBaseline.alphabetic,
                                          child: Tooltip(
                                            message: destinationStateLabels[
                                                        index]
                                                    .isEmpty
                                                ? 'Unnamed state: The state with ID “${entry.value.destinationStateIds[index]}” does not have a name.'
                                                : '',
                                            child: Text(
                                              label,
                                              style: style?.red(
                                                context,
                                                destinationStateLabels[index]
                                                        .isEmpty ||
                                                    isMultipleDestinationStates,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: shouldAddComma ? ', ' : '',
                                        ),
                                      ]);
                                    }),
                                    TextSpan(
                                      text: isMultipleDestinationStates
                                          ? ' }'
                                          : '',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
