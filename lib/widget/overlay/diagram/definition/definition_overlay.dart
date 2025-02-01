import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/resource/theme/diagram_theme.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/alphabet_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/diagram_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/final_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/initial_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/state/states_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/transition/transitions_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/definition/row/transition_function/transition_function_row.dart';
import 'package:fa_simulator/widget/overlay/diagram/diagram_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

OverlayEntry definitionOverlay() {
  OverlayEntry? overlay;
  overlay = OverlayEntry(
    builder: (context) => DiagramOverlay(
      close: () {
        overlay!.remove();
      },
      child: _DefinitionOverlay(),
    ),
  );
  return overlay;
}

class _DefinitionOverlay extends StatefulWidget {
  @override
  State<_DefinitionOverlay> createState() => _DefinitionOverlayState();
}

class _DefinitionOverlayState extends State<_DefinitionOverlay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: diagramTheme,
      home: Consumer<DiagramList>(
        builder: (context, provider, child) {
          List<StateType> states = DiagramList().states;
          List<TransitionType> transitions = DiagramList().transitions;
          TransitionFunctionType transitionFunction =
              DiagramList().compiler.transitionFunction;
          List<String> alphabet = DiagramList().allSymbol.toList();
          states.sort((a, b) => a.label.compareTo(b.label));

          DiagramErrorList errors = DiagramList().validator.errors;

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
                DiagramRow(
                  errors: errors,
                ),
                _buildDivider(context),
                AlphabetRow(
                  alphabet: alphabet,
                  errors: errors,
                ),
                _buildDivider(context),
                StatesRow(
                  states: states,
                  errors: errors,
                ),
                _buildDivider(context),
                TransitionsRow(
                  transitions: transitions,
                  errors: errors,
                ),
                _buildDivider(context),
                TransitionFunctionRow(
                  transitionFunction: transitionFunction,
                  errors: errors,
                ),
                _buildDivider(context),
                InitialRow(states: states),
                _buildDivider(context),
                FinalRow(states: states),
                _buildDivider(context),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildDivider(BuildContext context) {
  return Divider(
    color: Theme.of(context).colorScheme.outlineVariant,
  );
}
