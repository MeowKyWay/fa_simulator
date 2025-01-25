import 'dart:collection';

import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class TransitionFunctionType {
  SplayTreeSet<TransitionFunctionEntry> entries = SplayTreeSet(
    compareTransitionFunctionEntry,
  );

  void addEntry(TransitionFunctionEntry entry) {
    entries.add(entry);
  }

  TransitionFunctionEntry getEntry(String sourceStateId, String symbol) {
    if (!containEntry(sourceStateId, symbol)) {
      entries.add(
        TransitionFunctionEntry(
          sourceStateId: sourceStateId,
          destinationStateIds: [],
          symbol: symbol,
        ),
      );
    }
    return entries.firstWhere(
      (e) => e.sourceStateId == sourceStateId && e.symbol == symbol,
    );
  }

  bool containEntry(String sourceStateId, String symbol) {
    return entries.any(
      (e) => e.sourceStateId == sourceStateId && e.symbol == symbol,
    );
  }
}

class TransitionFunctionEntry {
  final String sourceStateId;
  final List<String> destinationStateIds;
  final String symbol;

  const TransitionFunctionEntry({
    required this.sourceStateId,
    required this.destinationStateIds,
    required this.symbol,
  });

  StateType get sourceState {
    try {
      return DiagramList().state(sourceStateId)!;
    } catch (e) {
      throw Exception(
          'transition_function_type.dart/TransitionFunctionEntry/sourceState: Source state $sourceStateId not found');
    }
  }

  List<StateType> get destinationStates {
    return destinationStateIds.map(
      (id) {
        try {
          return DiagramList().state(id)!;
        } catch (e) {
          throw Exception(
              'transition_function_type.dart/TransitionFunctionEntry/destinationStates: Destination state $id not found');
        }
      },
    ).toList();
  }

  @override
  bool operator ==(Object other) {
    if (other is TransitionFunctionEntry) {
      return sourceStateId == other.sourceStateId && symbol == other.symbol;
    }
    return false;
  }

  @override
  int get hashCode => sourceStateId.hashCode ^ symbol.hashCode;
}

int compareTransitionFunctionEntry(
    TransitionFunctionEntry a, TransitionFunctionEntry b) {
  int result = a.sourceState.label.compareTo(b.sourceState.label);
  if (result != 0) {
    return result;
  }
  return a.symbol.compareTo(b.symbol);
}
