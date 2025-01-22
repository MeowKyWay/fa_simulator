import 'dart:collection';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:sorted_list/sorted_list.dart';

typedef TransitionFunctionType
    = SplayTreeMap<TransitionFunctionKey, TransitionFunctionValue>;

class TransitionFunctionKey {
  final String sourceStateId;
  final String symbol;

  const TransitionFunctionKey({
    required this.sourceStateId,
    required this.symbol,
  });

  StateType? get sourceState {
    return DiagramList().state(sourceStateId);
  }

  String get sourceStateLabel {
    if (sourceState == null) {
      throw Exception('Source state $sourceStateId not found');
    }
    return sourceState?.label ?? 'unnamed state';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransitionFunctionKey &&
          runtimeType == other.runtimeType &&
          sourceStateId == other.sourceStateId &&
          symbol == other.symbol;

  @override
  int get hashCode => sourceStateId.hashCode ^ symbol.hashCode;
}

class TransitionFunctionValue {
  final SortedList<String> destinationStateIds = SortedList<String>(
    (a, b) => DiagramList().state(a)!.label.compareTo(
          DiagramList().state(b)!.label,
        ),
  );

  TransitionFunctionValue();

  List<StateType> get destinationStates {
    return destinationStateIds.map(
      (id) {
        try {
          return DiagramList().state(id)!;
        } catch (e) {
          throw Exception(
              'transition_function_type.dart/TransitionFunctionValue/destinationStates: Destination state $id not found');
        }
      },
    ).toList();
  }

  List<String> get destinationStateLabels {
    return destinationStateIds.map(
      (id) {
        try {
          return DiagramList().state(id)!.label;
        } catch (e) {
          throw Exception(
              'transition_function_type.dart/TransitionFunctionValue/destinationStatesLabel: Destination state $id not found');
        }
      },
    ).toList();
  }
}

int transitionFunctionComparator(
    TransitionFunctionKey a, TransitionFunctionKey b) {
  // Compare by sourceStateLabel first
  final sourceLabelComparison =
      a.sourceStateLabel.compareTo(b.sourceStateLabel);
  if (sourceLabelComparison != 0) {
    return sourceLabelComparison;
  }

  // If sourceStateLabel is the same, compare by symbol
  return a.symbol.compareTo(b.symbol);
}
