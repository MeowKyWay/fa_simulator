import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_symbol.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';

extension DiagramListCompile on DiagramList {
  TransitionFunctionType get transitionFunction {
    TransitionFunctionType transitionFunction;
    transitionFunction = TransitionFunctionType();
    for (TransitionType transition in transitions) {
      if (!transition.isComplete()) {
        continue;
      }
      for (String symbol in transition.symbols) {
        transitionFunction.addDestinationState(
          transition.sourceStateId!,
          symbol,
          transition.destinationStateId!,
        );
      }
    }
    // Add missing transitions for DFA
    if (FileProvider().faType == FAType.dfa) {
      for (StateType state in states) {
        for (String symbol in DiagramList().alphabet) {
          if (!transitionFunction.containEntry(state.id, symbol)) {
            transitionFunction.addEntry(
              TransitionFunctionEntry(
                sourceStateId: state.id,
                destinationStateIds: [],
                symbol: symbol,
              ),
            );
          }
        }
      }
    }
    return transitionFunction;
  }
}
