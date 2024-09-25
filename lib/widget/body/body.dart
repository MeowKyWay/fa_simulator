import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:fa_simulator/widget/body/component/body_palette_feedback.dart';
import 'package:fa_simulator/widget/body/component/body_states.dart';
import 'package:fa_simulator/widget/body/component/body_dragging_overlay.dart';
import 'package:fa_simulator/widget/body/component/body_feedback.dart';
import 'package:fa_simulator/widget/body/interactive_container.dart';
import 'package:fa_simulator/widget/body/input/body_gesture_detector.dart';
import 'package:fa_simulator/widget/body/decoration/grid_painter.dart';
import 'package:fa_simulator/widget/body/selection_box.dart';
import 'package:flutter/material.dart';

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
      child: InteractiveContainer(
        child: Container(
          width: bodySize.width,
          height: bodySize.height,
          decoration: BoxDecoration(
            color: primalyColor,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              // Draw the grid
              CustomPaint(
                size: bodySize,
                painter: GridPainter(),
              ),
              // To get the overlay that covers the states when dragging
              const BodyDraggingOverlay(),
              // Detect click and handle
              const BodyGestureDetector(),
              // Draw all of the states
              const BodyStates(),
              // Feedback when drag
              const BodyFeedback(),
              // Feedback when dragging from the pallete
              const BodyPaletteFeedback(),
              // Draw the selection box
              const SelectionBox(),
            ],
          ),
        ),
      ),
    );
  }
}
