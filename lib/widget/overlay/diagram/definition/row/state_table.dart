import 'package:fa_simulator/compiler/diagram_error_list.dart';
import 'package:fa_simulator/compiler/error/state_error.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
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
    List<DataColumn> columns = [
      DataColumn(label: Text('id')),
      DataColumn(label: Text('name')),
      DataColumn(label: Text('position')),
      DataColumn(label: Text('initial')),
      DataColumn(label: Text('final')),
    ];

    List<DataRow> rows = [];

    for (int i = 0; i < widget.states.length; i++) {
      StateType state = widget.states[i];
      StateErrors? error = widget.errors.stateError(state.id);

      StateErrorType? isUnnamed = error?.isUnnamed;
      StateErrorType? isDuplicateName = error?.isDuplicateName;
      StateErrorType? isDuplicateInitial = error?.isDuplicateInitial;
      StateErrorType? isNoFinal = error?.isNoFinal;
      StateErrorType? isNoInitial = error?.isNoInitial;

      TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

      DataRow row = DataRow(
        cells: [
          DataCell(Text(state.id)),
          DataCell(
            Tooltip(
              message: isUnnamed?.message ?? '',
              child: Text(
                state.label.isEmpty ? 'unnamed state' : state.label,
                style: textStyle?.red(
                  context,
                  (isDuplicateName ?? isUnnamed) != null,
                ),
              ),
            ),
          ),
          DataCell(
            Text('(${state.position.dx}, ${state.position.dy})'),
          ),
          DataCell(
            Tooltip(
              message:
                  isDuplicateInitial?.message ?? isNoInitial?.message ?? '',
              child: Text(
                state.isInitial ? 'yes' : 'no',
                style: textStyle?.red(
                  context,
                  isDuplicateInitial != null || isNoInitial != null,
                ),
              ),
            ),
          ),
          DataCell(
            Tooltip(
              message: isNoFinal?.message ?? '',
              child: Text(
                state.isFinal ? 'yes' : 'no',
                style: textStyle?.red(context, isNoFinal != null),
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
