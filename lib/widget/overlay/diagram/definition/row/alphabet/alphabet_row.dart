import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/symbol/update_alphabet_action.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_enums.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_errors.dart';
import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/alphabet/alphabel_text_field.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/alphabet/illegal_symbols_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/alphabet/unregistered_symbols_row.dart';
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
  bool isEditing = false;
  final FocusNode _focusNode = FocusNode();
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
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
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
                  if (!isEditing) ..._buildAlphabetText(style),
                  if (isEditing)
                    AlphabetTextField(
                      focusNode: _focusNode,
                      style: style,
                      onSubmitted: (value) {
                        setState(() {
                          isEditing = false;
                        });
                        AppActionDispatcher().execute(
                            UpdateAlphabetAction(symbols: value.split(',')));
                        log('AlphabetRow: onSubmitted: $value');
                      },
                    ),
                ],
              ),
            ),
            SizedBox(width: 10),
            if (!isEditing)
              Button(
                text: 'Edit',
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                style: ButtonVariant.contained,
              ),
          ],
        ),
        if (unregisteredSymbols.isNotEmpty)
          UnregisteredSymbolsRow(
            unregisteredSymbols: unregisteredSymbols,
            style: style,
          ),
        if (illegalSymbols.isNotEmpty)
          IllegalSymbolsRow(
            illegalSymbols: illegalSymbols,
            style: style,
          ),
      ],
    );
  }

  List<Widget> _buildAlphabetText(TextStyle? style) {
    return [
      Text(
        ': Σ = { ',
        style: style,
      ),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 650,
        ),
        child: RichText(
          softWrap: true,
          text: TextSpan(
            style: style,
            children: [
              ...List.generate(
                widget.alphabet.length,
                (index) {
                  String symbol = widget.alphabet[index];
                  SymbolErrors? error =
                      widget.errors[DiagramErrorClassType.symbolError][symbol];

                  bool isUnregistered =
                      error?.isError(SymbolErrorType.unregisteredSymbol) ??
                          false;
                  bool isIllegal =
                      error?.isError(SymbolErrorType.illegalSymbol) ?? false;

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
    ];
  }
}
