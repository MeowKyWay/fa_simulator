import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/symbol/add_symbols_action.dart';
import 'package:fa_simulator/action/symbol/remove_symbols_action.dart';
import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay/confirm_overlay.dart';
import 'package:flutter/material.dart';

class UnregisteredSymbolsRow extends StatefulWidget {
  final List<String> unregisteredSymbols;
  final TextStyle? style;

  const UnregisteredSymbolsRow({
    super.key,
    required this.unregisteredSymbols,
    required this.style,
  });

  @override
  State<UnregisteredSymbolsRow> createState() => _UnregisteredSymbolsRowState();
}

class _UnregisteredSymbolsRowState extends State<UnregisteredSymbolsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "{ ${widget.unregisteredSymbols.join(', ')} }",
          style: widget.style?.red(context),
          softWrap: true,
        ),
        Text(
          ' are not in the alphabet but are present in the diagram.',
          style: widget.style,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Button(
            text: 'Add',
            onPressed: () {
              setState(() {
                AppActionDispatcher().execute(AddSymbolsAction(
                  symbols: widget.unregisteredSymbols,
                ));
              });
            },
            style: ButtonVariant.contained,
            textStyle: widget.style,
            width: 50,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                  symbols: widget.unregisteredSymbols,
                ));
              });
            },
            style: ButtonVariant.contained,
            type: ButtonType.warning,
            textStyle: Theme.of(context).textTheme.labelSmall,
            width: 50,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
        ),
      ],
    );
  }
}
