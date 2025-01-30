import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:fa_simulator/widget/provider/start_arrow_feedback_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';

abstract class DiagramProvider {
  void reset();
}

void resetProvider() {
  DiagramList().reset();
  BodyProvider().reset();
  DiagramDraggingProvider().reset();
  NewTransitionProvider().reset();
  PalleteFeedbackProvider().reset();
  RenamingProvider().reset();
  TransitionDraggingProvider().reset();
  AppActionDispatcher().reset();
  StartArrowFeedbackProvider().reset();
}
