import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/symbol/add_symbols_action.dart';
import 'package:fa_simulator/action/symbol/remove_symbols_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay/confirm_overlay.dart';
import 'package:flutter/material.dart';

class PanelAlphabetProblem extends StatelessWidget {
  const PanelAlphabetProblem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        spacing: 3,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (DiagramList().unregisteredSymbols.isNotEmpty)
            Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    '{ ${DiagramList().unregisteredSymbols.join(', ')} } ',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
                Text('are not registered in the alphabet. '),
                Button(
                  text: 'Register',
                  style: ButtonVariant.contained,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  textStyle: Theme.of(context).textTheme.labelSmall,
                  onPressed: () {
                    AppActionDispatcher().execute(
                      AddSymbolsAction(
                        symbols: DiagramList().unregisteredSymbols,
                      ),
                    );
                  },
                ),
                SizedBox(width: 5),
                Button(
                  text: 'Remove',
                  style: ButtonVariant.contained,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  textStyle: Theme.of(context).textTheme.labelSmall,
                  onPressed: () async {
                    if (!await confirm(
                        'This will remove the symbols from every transition.',
                        context)) {
                      return;
                    }
                    AppActionDispatcher().execute(
                      RemoveSymbolsAction(
                        symbols: DiagramList().unregisteredSymbols,
                      ),
                    );
                  },
                )
              ],
            ),
          if (DiagramList().illegalSymbols.isNotEmpty)
            Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    '{ ${DiagramList().illegalSymbols.join(', ')} } ',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
                Text('are not allowed in this diagram. '),
                Button(
                  text: 'Remove',
                  style: ButtonVariant.contained,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  textStyle: Theme.of(context).textTheme.labelSmall,
                  onPressed: () {
                    AppActionDispatcher().execute(
                      RemoveSymbolsAction(
                        symbols: DiagramList().illegalSymbols,
                      ),
                    );
                  },
                )
              ],
            ),
        ],
      ),
    );
  }
}
