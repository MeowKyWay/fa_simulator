import 'dart:developer';

import 'package:fa_simulator/compiler/diagram_error_list.dart';
import 'package:fa_simulator/compiler/error/transition_error.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:flutter/material.dart';

class TransitionTable extends StatefulWidget {
  final List<TransitionType> transitions;
  final DiagramErrorList errors;

  const TransitionTable({
    super.key,
    required this.transitions,
    required this.errors,
  });

  @override
  State<TransitionTable> createState() => _TransitionTableState();
}

class _TransitionTableState extends State<TransitionTable> {
  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [
      DataColumn(label: Text('id')),
      DataColumn(label: Text('symbols')),
      DataColumn(label: Text('source')),
      DataColumn(label: Text('destination')),
    ];

    List<DataRow> rows = [];

    for (int i = 0; i < widget.transitions.length; i++) {
      TransitionType transition = widget.transitions[i];
      TransitionErrors? error = widget.errors.transitionError(transition.id);

      TransitionErrorType? isEmpty = error?.isEmpty;
      TransitionErrorType? isUndefinedSource = error?.isUndefinedSource;
      TransitionErrorType? isUndefinedDestination =
          error?.isUndefinedDestination;

      TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

      String sourceLabel = isUndefinedSource != null
          ? 'undefined'
          : transition.sourceState!.label;
      String destinationLabel = isUndefinedDestination != null
          ? 'undefined'
          : transition.destinationState!.label;
      sourceLabel = sourceLabel.isEmpty ? 'unnamed state' : sourceLabel;
      destinationLabel =
          destinationLabel.isEmpty ? 'unnamed state' : destinationLabel;

      log(transition.symbols.length.toString());

      DataRow row = DataRow(
        cells: [
          DataCell(Text(transition.id)),
          DataCell(
            Text(
              "{ ${transition.symbols.join(', ')} }",
              style: textStyle?.red(
                context,
                (isEmpty) != null,
              ),
            ),
          ),
          DataCell(
            Text(
              sourceLabel,
              style: textStyle?.red(context, isUndefinedSource != null),
            ),
          ),
          DataCell(
            Text(
              destinationLabel,
              style: textStyle?.red(context, isUndefinedDestination != null),
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
