import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:fa_simulator/widget/diagram/draggable/draggable_overlay.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram_feedback.dart';
import 'package:fa_simulator/widget/diagram/draggable/feedback_position_provider.dart';
import 'package:fa_simulator/widget/diagram/focus_overlay.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:fa_simulator/widget/body/input/body_gesture_detector.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/body/decoration/grid_painter.dart';
import 'package:fa_simulator/widget/body/selection_box.dart';
import 'package:fa_simulator/widget/body/zoomable_container.dart';
import 'package:fa_simulator/widget/diagram/state/diagram_state.dart';
import 'package:fa_simulator/widget/sidebar/pallete/pallete_feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: BodySingleton().bodyKey,
      // Listen to keyboard input for the entire body
      child: BodyKeyboardListener(
        // Handle zooming and panning
        child: ZoomableContainer(
          child: Container(
            width: bodySize.width,
            height: bodySize.height,
            color: primalyColor,
            child: Stack(
              children: [
                // Draw the grid
                CustomPaint(
                  size: bodySize,
                  painter: GridPainter(),
                ),
                // Overlay of the selected states
                Consumer<StateList>(builder: (context, stateList, child) {
                  return DraggableOverlay(
                    states: stateList.states,
                  );
                }),
                // Detect click and handle
                const BodyGestureDetector(),
                // Draw all of the states
                Consumer<StateList>(builder: (context, stateList, child) {
                  return Stack(children: [
                    ...stateList.states.map((state) {
                      return DiagramState(
                        state: state,
                      );
                    }),
                    ...stateList.states
                        .where((state) => state.hasFocus)
                        .map((state) {
                      return FocusOverlay(
                        position: state.position,
                      );
                    }),
                  ]);
                }),
                // Feedback when drag
                Consumer<FeedbackPositionProvider>(
                    builder: (context, feedbackPositionProvider, child) {
                  if (feedbackPositionProvider.size == null ||
                      feedbackPositionProvider.position == null) {
                    return Container();
                  }
                  return DiagramFeedback(
                    size: feedbackPositionProvider.size!,
                    position: feedbackPositionProvider.position!,
                  );
                }),
                //Feedback when dragging from the pallete
                Consumer<PalleteFeedbackProvider>(builder: (context, palleteFeedbackProvider, child) {
                  if (palleteFeedbackProvider.feedback == null ||
                      palleteFeedbackProvider.position == null) {
                    return Container();
                  }
                  return palleteFeedbackProvider.feedback!;
                }),
                // Draw the selection box
                const SelectionBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
