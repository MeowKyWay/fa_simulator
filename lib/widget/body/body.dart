import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
import 'package:fa_simulator/widget/body/component/body_transition_dragging_feedback.dart';
import 'package:fa_simulator/widget/body/component/body_transitions.dart';
import 'package:fa_simulator/widget/overlay/select_diagram_overlay.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/body/component/body_new_transition_feedback.dart';
import 'package:fa_simulator/widget/body/component/body_palette_feedback.dart';
import 'package:fa_simulator/widget/body/component/body_states.dart';
import 'package:fa_simulator/widget/body/component/body_dragging_overlay.dart';
import 'package:fa_simulator/widget/body/component/body_feedback.dart';
import 'package:fa_simulator/widget/body/interactive_container/interactive_container.dart';
import 'package:fa_simulator/widget/body/input/body_gesture_detector.dart';
import 'package:fa_simulator/widget/painter/grid_painter.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSelectDiagramOverlay();
    });
  }

  void _showSelectDiagramOverlay() {
    Overlay.of(context).insert(selectDiagramOverlay);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: BodyProvider().bodyKey,
      // Listen to keyboard input for the entire body
      child: InteractiveContainer(
        child: Container(
          width: bodySize.width,
          height: bodySize.height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
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
                painter: GridPainter(
                  primary: Theme.of(context).colorScheme.onSurface,
                  secondary: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              // To get the overlay that covers the states when dragging
              const BodyDraggingOverlay(),
              // Detect click and handle
              const BodyGestureDetector(),
              // Drag Target
              const BodyDragTarget(),
              // Draw all the states
              const BodyStates(),
              // Draw all the transitions
              const BodyTransitions(),
              // Feedback when drag
              const BodyFeedback(),
              // Feedback when dragging from the pallete
              const BodyPaletteFeedback(),
              // Draw the transition feedback
              const BodyTransitionDraggingFeedback(),
              // Draw new transition feedback
              const BodyNewTransitionFeedback(),
              // Draw the selection box
              const SelectionBox(),
            ],
          ),
        ),
      ),
    );
  }
}
