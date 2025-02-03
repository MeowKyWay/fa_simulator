import 'dart:developer';

import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:tuple/tuple.dart';

class DiagramSimulator {
  late TransitionFunctionType _transitionFunction;

  Tuple2<bool, List<StateType>> _traverse(
      StateType current, List<StateType> path, List<String> input) {
    if (input.isEmpty) {
      return Tuple2(DiagramList().finalStates.contains(current), path);
    }

    String symbol = input.removeAt(0);
    List<StateType> nextStates =
        _transitionFunction.get(current.id, symbol).destinationStates;

    for (StateType state in nextStates) {
      log('Current: ${current.label}, Next: ${state.label} with symbol: $symbol');
      List<StateType> newPath = List.from(path)..add(state);
      final result = _traverse(state, newPath, List.from(input));
      if (result.item1) {
        return result;
      }
    }
    return Tuple2(false, path);
  }

  Tuple2<bool, List<StateType>> simulate(List<String> input) {
    _transitionFunction = DiagramList().compiler.transitionFunction;
    StateType initial = DiagramList().initialStates.first;

    Tuple2<bool, List<StateType>> result = _traverse(initial, [initial], input);

    return result;
  }
}
