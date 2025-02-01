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

  bool get hasError {
    return hasDiagramError ||
        hasStateError ||
        hasTransitionError ||
        hasSymbolError ||
        hasTransitionFunctionError ||
        hasTransitionFunctionEntryError;
  }

  bool get hasDiagramError {
    return (errors[DiagramErrorClassType.diagramError] as DiagramErrors)
        .hasError;
  }

  bool get hasStateError {
    return (errors[DiagramErrorClassType.stateError]
            as Map<String, StateErrors>)
        .isNotEmpty;
  }

  bool get hasTransitionError {
    return (errors[DiagramErrorClassType.transitionError]
            as Map<String, TransitionErrors>)
        .isNotEmpty;
  }

  bool get hasSymbolError {
    return (errors[DiagramErrorClassType.symbolError]
            as Map<String, SymbolErrors>)
        .isNotEmpty;
  }

  bool get hasTransitionFunctionError {
    return (errors[DiagramErrorClassType.transitionFunctionError]
            as Map<Tuple2<String, String>, TransitionFunctionErrors>)
        .isNotEmpty;
  }

  bool get hasTransitionFunctionEntryError {
    return (errors[DiagramErrorClassType.transitionFunctionEntryError]
            as Map<Tuple2<String, String>, TransitionFunctionEntryErrors>)
        .isNotEmpty;
  }
}
