import 'package:fa_simulator/compiler/alphabet_compiler.dart';
import 'package:fa_simulator/compiler/state_compiler.dart';
import 'package:fa_simulator/compiler/transition_function_compiler.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/states_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/transition_function_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/diagram_overlay.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/alphabet_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

OverlayEntry definitionOverlay() {
  OverlayEntry? overlay;
  overlay = OverlayEntry(
    builder: (context) => DiagramOverlay(
      close: () {
        overlay!.remove();
      },
      child: Consumer<DiagramList>(
        builder: (context, provider, child) {
          List<StateType> states = DiagramList().states;
          TransitionFunctionType transitionFunction =
              DiagramList().transitionFunction;
          List<String> alphabet = DiagramList().alphabet.toList();
          List<String> unregisteredAlphabet =
              DiagramList().unregisteredAlphabet.toList();

          states.sort((a, b) => a.label.compareTo(b.label));

          Map<String, List<StateErrorType>> stateErrors =
              StateCompiler.compile(states);
          Map<String, List<AlphabetErrorType>> alphabetErrors =
              AlphabetCompiler.compile(alphabet, unregisteredAlphabet);
          Map<TransitionFunctionKey, List<TransitionFunctionErrorType>>
              transitionErrors =
              TransitionFunctionCompiler.compile(transitionFunction);

          return SizedBox(
            height: 700,
            width: 1000,
            child: ListView(
              children: [
                _buildDivider(context),
                Text(
                  'Definition',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                _buildDivider(context),
                StatesRow(
                  states: states,
                  errors: stateErrors,
                ),
                _buildDivider(context),
                AlphabetRow(
                  alphabet: alphabet,
                  unregisteredAlphabet: unregisteredAlphabet,
                ),
                _buildDivider(context),
                TransitionFunctionRow(
                  transitionFunction: transitionFunction,
                  stateErrors: stateErrors,
                  alphabetErrors: alphabetErrors,
                  transitionErrors: transitionErrors,
                ),
                _buildDivider(context),
              ],
            ),
          );
        },
      ),
    ),
  );
  return overlay;
}

Widget _buildDivider(BuildContext context) {
  return Divider(
    color: Theme.of(context).colorScheme.outlineVariant,
  );
}
