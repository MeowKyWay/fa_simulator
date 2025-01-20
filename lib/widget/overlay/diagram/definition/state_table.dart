import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
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
    List<StateType> states = DiagramList().states;

    List<DataColumn> columns = [
      DataColumn(label: Text('id')),
      DataColumn(label: Text('name')),
      DataColumn(label: Text('position')),
      DataColumn(label: Text('initial')),
      DataColumn(label: Text('final')),
    ];

    List<DataRow> rows = states.map((state) {
      return DataRow(
        cells: [
          DataCell(Text(state.id)),
          DataCell(
            Text(state.label == '' ? 'unnamed' : state.label),
          ),
          DataCell(
            Text('(${state.position.dx}, ${state.position.dy})'),
          ),
          DataCell(
            Text(state.isInitial ? 'yes' : 'no'),
          ),
          DataCell(
            Text(state.isFinal ? 'yes' : 'no'),
          ),
        ],
      );
    }).toList();

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
