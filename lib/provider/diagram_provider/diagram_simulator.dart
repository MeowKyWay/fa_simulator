import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/resource/diagram_constants.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:tuple/tuple.dart';
import 'dart:collection';

class DiagramSimulator {
  late TransitionFunctionType _transitionFunction;

  /// Compute the ε-closure of a given list of states
  List<StateType> _epsilonClosure(List<StateType> states) {
    List<StateType> closure = List.from(states);
    Queue<StateType> queue = Queue.from(states);

    while (queue.isNotEmpty) {
      StateType state = queue.removeFirst();
      try {
        var epsilonTransitions = _transitionFunction
            .get(state.id, DiagramCharacter.epsilon)
            .destinationStates;
        for (var nextState in epsilonTransitions) {
          if (!closure.map((e) => e.id).contains(nextState.id)) {
            closure.add(nextState);
            queue.add(nextState);
          }
        }
      } catch (_) {}
    }
    return closure;
  }

  /// Traverses the NFA using the given input
  Tuple2<bool, List<Tuple2<StateType, String>>> _traverse(
      List<StateType> currentStates,
      List<Tuple2<StateType, String>> path,
      List<String> input) {
    currentStates = _epsilonClosure(currentStates);

    if (input.isEmpty) {
      bool accepted = currentStates.any((state) => state.isFinal);
      return Tuple2(accepted, path);
    }

    String symbol = input.first;
    List<String> remainingInput = input.sublist(1);

    List<StateType> nextStates = [];
    for (var state in currentStates) {
      try {
        var transitions =
            _transitionFunction.get(state.id, symbol).destinationStates;
        for (var nextState in transitions) {
          if (!nextStates.map((e) => e.id).contains(nextState.id)) {
            nextStates.add(nextState);
          }
        }
      } catch (_) {}
    }

    if (nextStates.isEmpty) {
      return Tuple2(false, []);
    }

    List<Tuple2<StateType, String>> newPath = List.from(path);
    for (var state in nextStates) {
      newPath.add(Tuple2(state, symbol));
    }

    return _traverse(nextStates, newPath, remainingInput);
  }

  /// Simulates the NFA on the given input string
  Tuple2<bool, List<Tuple2<StateType, String>>> simulate(List<String> input) {
    _transitionFunction = DiagramList().compiler.transitionFunction;
    List<StateType> initialStates = [DiagramList().initialStates.first];

    return _traverse(initialStates, [Tuple2(initialStates.first, '')], input);
  }
}
