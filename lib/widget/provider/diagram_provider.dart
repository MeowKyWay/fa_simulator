import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/diagram_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/file_provider.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:fa_simulator/widget/provider/pallete_feedback_provider.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:fa_simulator/widget/provider/selection_area_provider.dart';
import 'package:fa_simulator/widget/provider/start_arrow_feedback_provider.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';

abstract class DiagramProvider {
  void reset();
}

void resetProvider() {
  BodyProvider().reset();
  DiagramDraggingProvider().reset();
  FileProvider().reset();
  KeyboardProvider().reset();
  NewTransitionProvider().reset();
  PalleteFeedbackProvider().reset();
  RenamingProvider().reset();
  TransitionDraggingProvider().reset();
  DiagramList().reset();
  SelectionAreaProvider().reset();
  AppActionDispatcher().reset();
  StartArrowFeedbackProvider().reset();
}