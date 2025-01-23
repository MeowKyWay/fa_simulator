import 'package:fa_simulator/compiler/state_compiler.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class StateTable extends StatelessWidget {
  final List<StateType> states;
  final Map<String, List<StateErrorType>> errors;

  const StateTable({
    super.key,
    required this.states,
    required this.errors,
  });

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [
      DataColumn(label: Text('id')),
      DataColumn(label: Text('name')),
      DataColumn(label: Text('position')),
      DataColumn(label: Text('initial')),
      DataColumn(label: Text('final')),
    ];

    List<DataRow> rows = [];

    for (int i = 0; i < states.length; i++) {
      StateType state = states[i];
      List<StateErrorType>? error = errors[state.id];

      bool isUnnamed = error?.contains(StateErrorType.unnamedState) ?? false;
      bool isDuplicateName =
          error?.contains(StateErrorType.duplicateStateName) ?? false;
      bool isDuplicateInitial =
          error?.contains(StateErrorType.duplicateInitialState) ?? false;
      bool isNoFinal = error?.contains(StateErrorType.noFinalState) ?? false;

      TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

      DataRow row = DataRow(
        cells: [
          DataCell(Text(state.id)),
          DataCell(
            Tooltip(
              message: isUnnamed
                  ? 'Unnamed state: The state with ID “${state.id}” does not have a name.'
                  : isDuplicateName
                      ? 'A state with the name “${state.label}” already exists. Please use a unique name.'
                      : '',
              child: Text(
                state.label.isEmpty ? 'unnamed state' : state.label,
                style: textStyle?.red(context, isDuplicateName || isUnnamed),
              ),
            ),
          ),
          DataCell(
            Text('(${state.position.dx}, ${state.position.dy})'),
          ),
          DataCell(
            Tooltip(
              message: isDuplicateInitial
                  ? 'Duplicate initial state: An initial state already exists.'
                  : '',
              child: Text(
                state.isInitial ? 'yes' : 'no',
                style: isDuplicateInitial ? textStyle?.red(context) : null,
              ),
            ),
          ),
          DataCell(
            Tooltip(
              message: isNoFinal
                  ? 'No final state: A DFA must have at least one final state.'
                  : '',
              child: Text(
                state.isFinal ? 'yes' : 'no',
                style: textStyle?.red(context, isNoFinal),
              ),
            ),
          ),
        ],
      );
      rows.add(row);
    }

    return DataTable(
      border: TableBorder(
        horizontalInside: BorderSide(
            width: 1, color: Theme.of(context).colorScheme.outlineVariant),
      ),
      dataTextStyle: Theme.of(context).textTheme.bodyMedium,
      columns: columns,
      rows: rows,
    );
  }
}
