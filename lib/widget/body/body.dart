import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram/draggable/draggable_overlay.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram_feedback.dart';
import 'package:fa_simulator/widget/diagram/draggable/feedback_position_provider.dart';
import 'package:fa_simulator/widget/diagram/state/state_list.dart';
import 'package:fa_simulator/widget/body/input/body_gesture_detector.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/body/decoration/grid_painter.dart';
import 'package:fa_simulator/widget/body/selection_box.dart';
import 'package:fa_simulator/widget/body/zoomable_container.dart';
import 'package:fa_simulator/widget/diagram/state/state_node.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double scale = 1.0;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
  }

  void _updateScale(double newScale) {
    if (scale == newScale) return;
    setState(() {
      scale = newScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Listen to keyboard input for the entire body
      child: BodyKeyboardListener(
        // Handle zooming and panning
        child: ZoomableContainer(
          onScaleChange: _updateScale,
          transformationController: _transformationController,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                // Draw the grid
                CustomPaint(
                  size: size,
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
                      return StateNode(
                        state: state,
                      );
                    }),
                  ]);
                }),
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
