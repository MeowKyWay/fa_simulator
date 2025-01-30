//This class should return the transition table
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/interface/jsonable.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_symbol.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition_function_type.dart';

class DiagramCompiler implements Jsonable {
  final DiagramList diagram;
  late TransitionFunctionType transitionFunction;

  DiagramCompiler(
    this.diagram,
  );

  void compile() {
    transitionFunction = TransitionFunctionType();
    for (TransitionType transition in diagram.transitions) {
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
  }

  @override
  Map<String, dynamic> toJson() {
    return transitionFunction.toJson();
  }
}
