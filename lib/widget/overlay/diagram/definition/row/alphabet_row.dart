import 'dart:collection';

import 'package:fa_simulator/compiler/diagram_error_list.dart';
import 'package:fa_simulator/compiler/error/symbol_error.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list_alphabet.dart';
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
    SplayTreeSet<String> unregisteredAlphabet =
        DiagramList().unregisteredAlphabet;
    SplayTreeSet<String> illegalAlphabet = DiagramList().illegalAlphabet;

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
                  widget.errors.symbolErrors.isNotEmpty,
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
                        SymbolErrors? error = widget.errors.symbolError(symbol);
                        return TextSpan(
                          children: [
                            TextSpan(
                              text: symbol,
                              style: style?.red(
                                context,
                                error?.isUnRegistered != null ||
                                    error?.isIllegalSymbol != null,
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
        if (unregisteredAlphabet.isNotEmpty)
          Row(
            children: [
              Text(
                "{ ${unregisteredAlphabet.join(', ')} }",
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
                      DiagramList().addAllAlphabet(unregisteredAlphabet);
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
                      DiagramList().removeUnregisteredAlphabet();
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
        if (illegalAlphabet.isNotEmpty)
          Row(
            children: [
              Text(
                "{ ${illegalAlphabet.join(', ')} }",
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
                  onPressed: () {
                    setState(() {
                      DiagramList().removeIllegalAlphabet();
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
