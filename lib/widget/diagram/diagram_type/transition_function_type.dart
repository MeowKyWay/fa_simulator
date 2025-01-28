import 'dart:collection';

import 'package:fa_simulator/widget/components/interface/jsonable.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class TransitionFunctionType implements Jsonable {
  TransitionFunctionType();

  SplayTreeSet<TransitionFunctionEntry> entries = SplayTreeSet(
    compareTransitionFunctionEntry,
  );

  TransitionFunctionEntry get(String id, String symbol) {
    try {
      return entries.firstWhere(
        (e) => e.sourceStateId == id && e.symbol == symbol,
      );
    } catch (e) {
      throw Exception(
          'transition_function_type.dart/TransitionFunctionType/get: Transition function entry not found');
    }
  }

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

  void addDestinationState(
    String sourceStateId,
    String symbol,
    String destinationStateId,
  ) {
    TransitionFunctionEntry? entry;
    if (!containEntry(sourceStateId, symbol)) {
      entry = TransitionFunctionEntry(
        sourceStateId: sourceStateId,
        destinationStateIds: [],
        symbol: symbol,
      );
      entries.add(entry);
    }
    entry = entry ??
        entries.firstWhere(
            (e) => e.sourceStateId == sourceStateId && e.symbol == symbol);
    entry.destinationStateIds.add(destinationStateId);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'entries': entries.map((e) => e.toJson()).toList(),
    };
  }

  factory TransitionFunctionType.fromJson(Map<String, dynamic> map) {
    TransitionFunctionType transitionFunction = TransitionFunctionType();
    for (Map<String, dynamic> entry in map['entries']) {
      transitionFunction.addEntry(TransitionFunctionEntry.fromJson(entry));
    }
    return transitionFunction;
  }
}

class TransitionFunctionEntry implements Jsonable {
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
    List<StateType> destinationStates = [];
    for (String destinationStateId in destinationStateIds) {
      try {
        destinationStates.add(DiagramList().state(destinationStateId)!);
      } catch (e) {
        throw Exception(
            'transition_function_type.dart/TransitionFunctionEntry/destinationStates: Destination state $destinationStateId not found');
      }
    }
    return destinationStates;
  }

  @override
  String toString() {
    return 'TransitionFunctionEntry(sourceStateId: $sourceStateId, destinationStateIds: $destinationStateIds, symbol: $symbol)';
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'sourceStateId': sourceStateId,
      'destinationStateIds': destinationStateIds,
      'symbol': symbol,
    };
  }

  factory TransitionFunctionEntry.fromJson(Map<String, dynamic> map) {
    return TransitionFunctionEntry(
      sourceStateId: map['sourceStateId'],
      destinationStateIds: List<String>.from(map['destinationStateIds']),
      symbol: map['symbol'],
    );
  }
}

int compareTransitionFunctionEntry(
    TransitionFunctionEntry a, TransitionFunctionEntry b) {
  int result;
  result = a.sourceState.label.compareTo(b.sourceState.label);
  if (result != 0) {
    return result;
  }
  result = a.symbol.compareTo(b.symbol);
  if (result != 0) {
    return result;
  }
  return a.sourceStateId.compareTo(b.sourceStateId);
}
