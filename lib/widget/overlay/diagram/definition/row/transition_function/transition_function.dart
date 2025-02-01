import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_enums.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_errors.dart';
import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/extension/widget_span_extension.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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

    Map<Tuple2<String, String>, TransitionFunctionErrors> errorMap =
        errors[DiagramErrorClassType.transitionFunctionError];

    return Column(
      spacing: 10,
      children: [
        Row(
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
                  ...transitionFunction.entries.map<RichText>(
                    (entry) {
                      TransitionFunctionEntryErrors? error;
                      error = errors[DiagramErrorClassType
                              .transitionFunctionEntryError]
                          [Tuple2(entry.sourceState.id, entry.symbol)];

                      bool isMultipleDestination = error?.isError(
                              TransitionFunctionEntryErrorType
                                  .multipleDestinationStates) ??
                          false;

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
                        text: WidgetSpan(
                          child: RichText(
                            text: TextSpan(
                              style: style,
                              children: [
                                TextSpan(
                                  text: ' • δ( $sourceStateLabel, $symbol ) = ',
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: Text(
                                    destString,
                                    style: style?.red(
                                      context,
                                      isMultipleDestination,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).baseAlign(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Missing transitions: ',
              style: style?.red(context),
            ),
            Column(
              children: [
                ...errorMap.entries.map<Widget>((entry) {
                  String sourceState =
                      DiagramList().state(entry.key.item1).label;
                  if (sourceState.isEmpty) {
                    sourceState = 'unnamed state';
                  }
                  String symbol = entry.key.item2;
                  return Text(
                    ' • δ( $sourceState, $symbol )',
                    style: style?.red(context),
                  );
                }),
              ],
            )
          ],
        )
      ],
    );
  }
}
