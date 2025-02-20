import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/resource/diagram_constants.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:flutter/material.dart';

class PanelTransitionFunction extends StatelessWidget {
  final TransitionFunctionType transitionFunction;

  const PanelTransitionFunction({
    super.key,
    required this.transitionFunction,
  });

  @override
  Widget build(BuildContext context) {
    List<StateType> states = DiagramList().states;

    final columns = [
      DataColumn(
          label: Text(
        'State',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      )),
      ...List.generate(DiagramList().alphabet.length, (index) {
        return DataColumn(
            label: Text(
          DiagramList().alphabet[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ));
      })
    ];

    final rows = List.generate(
      states.length,
      (index) {
        final s = states[index];
        return DataRow(cells: [
          DataCell(Center(child: Text(s.label))),
          ...List.generate(
            DiagramList().alphabet.length,
            (index) {
              final symbol = DiagramList().alphabet[index];
              try {
                final dest =
                    transitionFunction.get(s.id, symbol).destinationStates;
                final label = dest.map((e) => e.label).toList()..sort();
                bool isDet = dest.length == 1;
                return DataCell(Center(
                  child: Text(
                    isDet ? label.first : '{ ${label.join(', ')} }',
                  ),
                ));
              } catch (e) {
                return DataCell(Center(child: Text(DiagramCharacter.emptySet)));
              }
            },
          ),
        ]);
      },
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'δ = ',
          ),
          DataTable(
            columns: columns,
            rows: rows,
            headingTextStyle: Theme.of(context).textTheme.labelSmall,
            dataTextStyle: Theme.of(context).textTheme.labelSmall,
            border: TableBorder.all(
              color: Theme.of(context).colorScheme.outline,
            ),
            headingRowHeight: 20,
            dataRowMinHeight: 20,
            dataRowMaxHeight: 20,
          ),
        ],
      ),
    );
  }
}
