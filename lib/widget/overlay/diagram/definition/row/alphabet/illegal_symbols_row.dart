import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/symbol/remove_symbols_action.dart';
import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay/confirm_overlay.dart';
import 'package:flutter/material.dart';

class IllegalSymbolsRow extends StatefulWidget {
  final List<String> illegalSymbols;
  final TextStyle? style;

  const IllegalSymbolsRow({
    super.key,
    required this.illegalSymbols,
    required this.style,
  });

  @override
  State<IllegalSymbolsRow> createState() => _IllegalSymbolsRowState();
}

class _IllegalSymbolsRowState extends State<IllegalSymbolsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "{ ${widget.illegalSymbols.join(', ')} }",
          style: widget.style?.red(context),
          softWrap: true,
        ),
        Text(
          ' are not permitted in this diagram.',
          style: widget.style,
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
                  symbols: widget.illegalSymbols,
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
