import 'package:fa_simulator/provider/diagram_provider/error/diagram_errors.dart';
import 'package:tuple/tuple.dart';

enum DiagramErrorClassType {
  diagramError,
  stateError,
  transitionError,
  symbolError,
  transitionFunctionError,
  transitionFunctionEntryError,
}

class DiagramErrorList {
  Map<DiagramErrorClassType, dynamic> errors = {
    DiagramErrorClassType.diagramError: DiagramErrors(),
    DiagramErrorClassType.stateError: <String, StateErrors>{},
    DiagramErrorClassType.transitionError: <String, TransitionErrors>{},
    DiagramErrorClassType.symbolError: <String, SymbolErrors>{},
    DiagramErrorClassType.transitionFunctionError:
        <Tuple2<String, String>, TransitionFunctionErrors>{},
    DiagramErrorClassType.transitionFunctionEntryError:
        <Tuple2<String, String>, TransitionFunctionEntryErrors>{},
  };

  operator [](DiagramErrorClassType type) {
    return errors[type];
  }
}
