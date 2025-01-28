import 'package:fa_simulator/compiler/diagram_error_list.dart';
import 'package:fa_simulator/compiler/error/state_error.dart';
import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/extension/text_extension.dart';
import 'package:fa_simulator/widget/components/extension/text_field_extension.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class StateTable extends StatefulWidget {
  final List<StateType> states;
  final List<StateType> statesCopy;
  final DiagramErrorList errors;

  const StateTable({
    super.key,
    required this.states,
    required this.statesCopy,
    required this.errors,
  });

  @override
  State<StateTable> createState() => _StateTableState();
}

class _StateTableState extends State<StateTable> {
  late List<TextEditingController> _nameControllers;
  late List<FocusNode> _nameFocusNodes;

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [
      DataColumn(label: Text('id').center()),
      DataColumn(label: Text('name').center()),
      DataColumn(label: Text('position').center()),
      DataColumn(label: Text('initial').center()),
      DataColumn(label: Text('final').center()),
    ];

    List<DataRow> rows = [];

    for (int i = 0; i < widget.statesCopy.length; i++) {
      StateType state = widget.statesCopy[i];
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
            showEditIcon: true,
            TextField(
              focusNode: _nameFocusNodes[i], // Use the unique focus node
              controller: _nameControllers[i], // Use the unique controller
              decoration: InputDecoration.collapsed(
                hintText: 'unnamed state ',
                hintStyle: textStyle?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary.withAlpha(
                        (0.5 * 255).toInt(),
                      ),
                ),
              ),
              style: textStyle?.red(
                context,
                (isDuplicateName) != null,
              ),
            ).plain(),
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

  @override
  void initState() {
    super.initState();
    // Initialize the lists with a controller and focus node for each state
    _nameControllers = widget.statesCopy
        .map((state) => TextEditingController(text: state.label))
        .toList();
    _nameFocusNodes =
        List.generate(widget.statesCopy.length, (_) => FocusNode());
  }

  @override
  void didUpdateWidget(StateTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the length of states changes, update the controllers and focus nodes
    if (widget.statesCopy.length != oldWidget.statesCopy.length) {
      // Dispose of the old controllers and focus nodes
      for (var controller in _nameControllers) {
        controller.dispose();
      }
      for (var focusNode in _nameFocusNodes) {
        focusNode.dispose();
      }

      // Recreate the lists with the new length
      _nameControllers = widget.statesCopy
          .map((state) => TextEditingController(text: state.label))
          .toList();
      _nameFocusNodes =
          List.generate(widget.statesCopy.length, (_) => FocusNode());
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    for (var focusNode in _nameFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
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
