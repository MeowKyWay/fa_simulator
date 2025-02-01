import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/symbol/add_symbols_action.dart';
import 'package:fa_simulator/action/symbol/remove_symbols_action.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_enums.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_errors.dart';
import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay/confirm_overlay.dart';
import 'package:flutter/material.dart';

class AlphabetRow extends StatefulWidget {
  final List<String> alphabet;
  final DiagramErrorList errors;

  const AlphabetRow({
    super.key,
    required this.alphabet,
    required this.errors,
  });

  @override
  State<AlphabetRow> createState() => _AlphabetRowState();
}

class _AlphabetRowState extends State<AlphabetRow> {
  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.labelMedium;
    List<String> unregisteredSymbols = DiagramList().unregisteredSymbols;
    List<String> illegalSymbols = DiagramList().illegalSymbols;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 26,
              width: 100,
              child: Text(
                'Alphabet',
                style: style?.red(
                  context,
                  widget.errors.hasSymbolError,
                ),
              ),
            ),
            Text(
              ': Σ = { ',
              style: style,
            ),
            Expanded(
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: style,
                  children: [
                    ...List.generate(
                      widget.alphabet.length,
                      (index) {
                        String symbol = widget.alphabet[index];
                        SymbolErrors? error = widget
                            .errors[DiagramErrorClassType.symbolError][symbol];

                        bool isUnregistered = error
                                ?.isError(SymbolErrorType.unregisteredSymbol) ??
                            false;
                        bool isIllegal =
                            error?.isError(SymbolErrorType.illegalSymbol) ??
                                false;

                        return TextSpan(
                          children: [
                            TextSpan(
                              text: symbol,
                              style: style?.red(
                                context,
                                isUnregistered || isIllegal,
                              ),
                            ),
                            if (index != widget.alphabet.length - 1)
                              TextSpan(text: ', '),
                          ],
                        );
                      },
                    ),
                    TextSpan(text: ' }'),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (unregisteredSymbols.isNotEmpty)
          Row(
            children: [
              Text(
                "{ ${unregisteredSymbols.join(', ')} }",
                style: style?.red(context),
                softWrap: true,
              ),
              Text(
                ' are not in the alphabet but are present in the diagram.',
                style: style,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Button(
                  text: 'Add',
                  onPressed: () {
                    setState(() {
                      AppActionDispatcher().execute(AddSymbolsAction(
                        symbols: unregisteredSymbols,
                      ));
                    });
                  },
                  style: ButtonVariant.contained,
                  textStyle: style,
                  width: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Button(
                  text: 'Remove',
                  onPressed: () async {
                    if (!await confirm(
                      'This action will remove every symbol in the list from all transitions.',
                      context,
                    )) {
                      return;
                    }
                    setState(() {
                      AppActionDispatcher().execute(RemoveSymbolsAction(
                        symbols: unregisteredSymbols,
                      ));
                    });
                  },
                  style: ButtonVariant.contained,
                  type: ButtonType.warning,
                  textStyle: Theme.of(context).textTheme.labelSmall,
                  width: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              ),
            ],
          ),
        if (illegalSymbols.isNotEmpty)
          Row(
            children: [
              Text(
                "{ ${illegalSymbols.join(', ')} }",
                style: style?.red(context),
                softWrap: true,
              ),
              Text(
                ' are not permitted in this diagram.',
                style: style,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Button(
                  text: 'Remove',
                  onPressed: () async {
                    if (!await confirm(
                      'This action will remove every symbol in the list from all transitions.',
                      context,
                    )) {
                      return;
                    }
                    setState(() {
                      AppActionDispatcher().execute(RemoveSymbolsAction(
                        symbols: illegalSymbols,
                      ));
                    });
                  },
                  style: ButtonVariant.contained,
                  type: ButtonType.warning,
                  textStyle: Theme.of(context).textTheme.labelSmall,
                  width: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
