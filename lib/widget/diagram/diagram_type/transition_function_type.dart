import 'dart:collection';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

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
  final String destinationStateId;

  const TransitionFunctionValue({
    required this.destinationStateId,
  });

  StateType? get destinationState {
    return DiagramList().state(destinationStateId);
  }

  String get destinationStateLabel {
    if (destinationState == null) {
      throw Exception('Destination state $destinationStateId not found');
    }
    return destinationState?.label ?? 'unnamed state';
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
