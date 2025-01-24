import 'package:fa_simulator/compiler/diagram_error_list.dart';
import 'package:fa_simulator/compiler/error/transition_function_entry_error.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:flutter/material.dart';

class TransitionFunction extends StatelessWidget {
  final TransitionFunctionType transitionFunction;
  final DiagramErrorList errors;

  const TransitionFunction({
    super.key,
    required this.transitionFunction,
    required this.errors,
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
              for (TransitionFunctionEntry entry in transitionFunction.entries)
                Builder(
                  builder: (context) {
                    TransitionFunctionEntryErrors? error;
                    error = errors.transitionFunctionEntryError(
                      entry.sourceStateId,
                      entry.symbol,
                    );

                    TransitionFunctionEntryErrorType? isMultipleDestination =
                        error?.isMultipleDestination;
                    TransitionFunctionEntryErrorType? isMissing =
                        error?.isMissing;

                    String sourceStateLabel = entry.sourceState.label;
                    List<String> destinationStateLabels =
                        entry.destinationStates.map((e) => e.label).toList();

                    String symbol = entry.symbol;
                    if (sourceStateLabel.isEmpty) {
                      sourceStateLabel = 'unnamed state';
                    }

                    String destString = destinationStateLabels
                        .map((e) => e.isEmpty ? 'unnamed state' : e)
                        .join(', ');

                    destString = destinationStateLabels.length == 1
                        ? destString
                        : '{ $destString }';

                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: ' • δ( $sourceStateLabel, $symbol ) = ',
                            style: style,
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: Tooltip(
                              message: isMultipleDestination?.message ?? '',
                              child: Text(
                                destString,
                                style: style?.red(
                                    context, isMultipleDestination != null),
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
