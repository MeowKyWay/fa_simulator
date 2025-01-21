import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';

class TransitionFunctionEntry {
  final String sourceStateId;
  final String destinationStateId;

  final String symbol;

  const TransitionFunctionEntry({
    required this.sourceStateId,
    required this.destinationStateId,
    required this.symbol,
  });

  StateType? get sourceState {
    return DiagramList().state(sourceStateId);
  }

  StateType? get destinationState {
    return DiagramList().state(destinationStateId);
  }

  String get sourceStateLabel {
    if (sourceState == null) {
      throw Exception('Source state $sourceStateId not found');
    }
    return sourceState?.label ?? 'unnamed state';
  }

  String get destinationStateLabel {
    if (destinationState == null) {
      throw Exception('Destination state $destinationStateId not found');
    }
    return destinationState?.label ?? 'unnamed state';
  }
}
