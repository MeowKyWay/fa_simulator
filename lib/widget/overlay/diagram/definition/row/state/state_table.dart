import 'dart:developer';

import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_enums.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_errors.dart';
import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class StateTable extends StatefulWidget {
  final List<StateType> states;
  final DiagramErrorList errors;

  const StateTable({
    super.key,
    required this.states,
    required this.errors,
  });

  @override
  State<StateTable> createState() => _StateTableState();
}

class _StateTableState extends State<StateTable> {
  @override
  Widget build(BuildContext context) {
    log('StateTable build');

    List<DataColumn> columns = [
      DataColumn(label: Text('no.')),
      DataColumn(label: Text('name')),
      DataColumn(label: Text('position')),
      DataColumn(label: Text('initial')),
      DataColumn(label: Text('final')),
      DataColumn(label: Text('error')),
    ];

    List<DataRow> rows = [];

    for (int i = 0; i < widget.states.length; i++) {
      StateType state = widget.states[i];
      StateErrors? error =
          widget.errors[DiagramErrorClassType.stateError][state.id];

      bool isDuplicateName =
          error?.isError(StateErrorType.duplicateStateName) ?? false;
      bool isUnnamed = error?.isError(StateErrorType.unnamedState) ?? false;

      TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

      DataRow row = DataRow(
        cells: [
          DataCell(Text((i + 1).toString())),
          DataCell(
            Text(
              state.label.isEmpty ? 'unnamed state' : state.label,
              style: textStyle?.red(
                context,
                isDuplicateName || isUnnamed,
              ),
            ),
          ),
          DataCell(
            Text('(${state.position.dx}, ${state.position.dy})'),
          ),
          DataCell(
            Text(
              state.isInitial ? 'yes' : 'no',
              style: textStyle?.red(
                context,
              ),
            ),
          ),
          DataCell(
            Text(
              state.isFinal ? 'yes' : 'no',
              style: textStyle,
            ),
          ),
          DataCell(
            Text(
              error?.errorMessage ?? '',
              style: textStyle?.red(
                context,
                error != null,
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
      dataRowMaxHeight: double.infinity, // For dynamic row content height
      dataTextStyle: Theme.of(context).textTheme.bodyMedium,
      columns: columns,
      rows: rows,
    );
  }

  // void _onSort(
  //   columnIndex,
  //   ascending,
  //   int Function(StateType, StateType) compare,
  // ) {
  //   setState(() {
  //     _sortIndex = columnIndex;
  //     _sortAscending = ascending;
  //     widget.states.sort((a, b) => compare(a, b) * (ascending ? 1 : -1));
  //   });
  // }
}
