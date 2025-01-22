import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class StateTable extends StatelessWidget {
  final List<StateType> states;

  const StateTable({
    super.key,
    required this.states,
  });

  @override
  Widget build(BuildContext context) {
    //TODO use compiler
    List<DataColumn> columns = [
      DataColumn(label: Text('id')),
      DataColumn(label: Text('name')),
      DataColumn(label: Text('position')),
      DataColumn(label: Text('initial')),
      DataColumn(label: Text('final')),
    ];

    bool initialFlag = false;

    List<DataRow> rows = [];
    for (int i = 0; i < states.length; i++) {
      StateType state = states[i];

      bool isDuplicateName = false;
      if (i > 0 && state.label.isNotEmpty) {
        if (state.label == states[i - 1].label) {
          isDuplicateName = true;
        }
      }
      bool isDuplicateInitial = initialFlag && state.isInitial;

      TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

      DataRow row = DataRow(
        cells: [
          DataCell(Text(state.id)),
          DataCell(
            Tooltip(
              message: state.label == ''
                  ? 'Unnamed state: The state with ID “${state.id}” does not have a name.'
                  : isDuplicateName
                      ? 'A state with the name “${state.label}” already exists. Please use a unique name.'
                      : '',
              child: Text(
                state.label.isEmpty ? 'unnamed state' : state.label,
                style: textStyle?.error(
                    context, isDuplicateName || state.label.isEmpty),
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
                style: isDuplicateInitial ? textStyle?.error(context) : null,
              ),
            ),
          ),
          DataCell(
            Text(state.isFinal ? 'yes' : 'no'),
          ),
        ],
      );
      rows.add(row);
      if (state.isInitial) {
        initialFlag = true;
      }
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
