import 'package:fa_simulator/widget/overlay/diagram/diagram_overlay.dart';
import 'package:flutter/material.dart';

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
    return Container();
    // return MaterialApp(
    //   theme: diagramTheme,
    //   home: Consumer<DiagramList>(
    //     builder: (context, provider, child) {
    //       List<StateType> states = DiagramList().states;
    //       List<TransitionType> transitions = DiagramList().transitions;
    //       TransitionFunctionType transitionFunction =
    //           DiagramList().compiler.transitionFunction;
    //       List<String> alphabet = DiagramList().allSymbol.toList();
    //       states.sort((a, b) => a.label.compareTo(b.label));

    //       DiagramErrorList errors = DiagramList().validator.errors;

    //       return SizedBox(
    //         height: 700,
    //         width: 1000,
    //         child: ListView(
    //           children: [
    //             _buildDivider(context),
    //             Text(
    //               'Definition',
    //               style: Theme.of(context).textTheme.titleLarge,
    //             ),
    //             _buildDivider(context),
    //             DiagramRow(),
    //             _buildDivider(context),
    //             AlphabetRow(
    //               alphabet: alphabet,
    //               errors: errors,
    //             ),
    //             _buildDivider(context),
    //             StatesRow(
    //               states: states,
    //               errors: errors,
    //             ),
    //             _buildDivider(context),
    //             TransitionsRow(
    //               transitions: transitions,
    //               errors: errors,
    //             ),
    //             _buildDivider(context),
    //             TransitionFunctionRow(
    //               transitionFunction: transitionFunction,
    //               errors: errors,
    //             ),
    //             _buildDivider(context),
    //             InitialRow(states: states),
    //             _buildDivider(context),
    //             FinalRow(states: states),
    //             _buildDivider(context),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}

Widget _buildDivider(BuildContext context) {
  return Divider(
    color: Theme.of(context).colorScheme.outlineVariant,
  );
}
