import 'package:fa_simulator/compiler/error/diagram_error.dart';
import 'package:fa_simulator/compiler/error/state_error.dart';
import 'package:fa_simulator/compiler/error/symbol_error.dart';
import 'package:fa_simulator/compiler/error/transition_error.dart';
import 'package:fa_simulator/compiler/error/transition_function_entry_error.dart';

class DiagramErrorList {
  List<DiagramErrors> errors = [];

  StateErrors? stateError(String stateId) {
    try {
      return stateErrors.firstWhere((e) => e.stateId == stateId);
    } catch (e) {
      return null;
    }
  }

  TransitionErrors? transitionError(String transitionId) {
    try {
      return transitionErrors.firstWhere((e) => e.transitionId == transitionId);
    } catch (e) {
      return null;
    }
  }

  SymbolErrors? symbolError(String symbol) {
    try {
      return symbolErrors.firstWhere((e) => e.symbol == symbol);
    } catch (e) {
      return null;
    }
  }

  TransitionFunctionEntryErrors? transitionFunctionEntryError(
      String stateId, String symbol) {
    try {
      return transitionFunctionEntryErrors
          .firstWhere((e) => e.stateId == stateId && e.symbol == symbol);
    } catch (e) {
      return null;
    }
  }
}

extension DiagramErrorListExtension on DiagramErrorList {
  List<StateErrors> get stateErrors {
    return errors.whereType<StateErrors>().toList();
  }

  List<TransitionErrors> get transitionErrors {
    return errors.whereType<TransitionErrors>().toList();
  }

  List<SymbolErrors> get symbolErrors {
    return errors.whereType<SymbolErrors>().toList();
  }

  List<TransitionFunctionEntryErrors> get transitionFunctionEntryErrors {
    return errors.whereType<TransitionFunctionEntryErrors>().toList();
  }

  void addError(DiagramErrors error) {
    errors.add(error);
  }

  bool get hasErrors {
    return errors.isNotEmpty;
  }

  bool get hasStateErrors {
    return stateErrors.isNotEmpty;
  }

  bool get hasTransitionErrors {
    return transitionErrors.isNotEmpty;
  }

  bool get hasSymbolErrors {
    return symbolErrors.isNotEmpty;
  }

  bool get hasTransitionFunctionEntryErrors {
    return transitionFunctionEntryErrors.isNotEmpty;
  }
}
