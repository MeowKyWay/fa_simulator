import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
import 'package:flutter/material.dart';

class TransitionFunction extends StatelessWidget {
  const TransitionFunction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TransitionFunctionType transitionFunction =
        DiagramList().transitionFunction;

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
                    String sourceStateLabel = entry.key.sourceStateLabel;
                    List<String> destinationStateLabels =
                        entry.value.destinationStateLabels;
                    String symbol = entry.key.symbol;
                    if (sourceStateLabel.isEmpty) {
                      sourceStateLabel = 'unnamed state';
                    }

                    bool isDestinationError = false;
                    bool isSymbolError = false;

                    if (FileProvider().faType == FAType.dfa) {
                      if (destinationStateLabels.length > 1) {
                        isDestinationError = true;
                      }
                    }
                    if (!DiagramList().alphabet.contains(symbol)) {
                      isSymbolError = true;
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
                            text: ' • δ($sourceStateLabel, $symbol) = ',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          WidgetSpan(
                            child: Tooltip(
                              message:
                                  'The symbol $symbol was not found in the alphabet.',
                              child: Text(
                                symbol,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.error(context, isSymbolError),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: ') = ',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          WidgetSpan(
                            child: Tooltip(
                              message: 'A DFA does not allow multiple destination states for the same state and symbol.',
                              child: Text(
                                value,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.error(context, isDestinationError),
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
