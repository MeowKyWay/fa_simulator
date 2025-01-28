import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/clip/ring_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/transition_dragging_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StateHoverOverlay extends StatefulWidget {
  final StateType state;

  const StateHoverOverlay({
    super.key,
    required this.state,
  });

  @override
  State<StateHoverOverlay> createState() => _StateHoverOverlayState();
}

class _StateHoverOverlayState extends State<StateHoverOverlay> {
  final double _ringWidth = stateFocusOverlayRingWidth;
  late double _innerRadius;
  late double _outerRadius;

  bool _isHovered = false;

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _innerRadius = stateSize / 2 - _ringWidth;
    _outerRadius = stateSize / 2 + _ringWidth;

    return ClipPath(
      key: _key,
      clipper: RingClipper(
        innerRadius: _innerRadius,
        outerRadius: _outerRadius,
      ),
      child: IgnorePointer(
        ignoring: NewTransitionProvider().isDraggingNewTransition ||
            TransitionDraggingProvider().isDragging,
        child: Stack(
          children: [
            NewTransitionDraggable(
              state: widget.state,
              child: MouseRegion(
                onHover: _onHover,
                onExit: _onExit,
                onEnter: _onEnter,
                child: Container(
                  width: stateSize + (_ringWidth * 2),
                  height: stateSize + (_ringWidth * 2),
                  color: _isHovered
                      ? Theme.of(context).hoverColor
                      : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Offset calculateNewPoint(Offset startPoint, double distance, double angle) {
    // Convert the angle to radians

    // Calculate the new x and y coordinates
    double x = startPoint.dx + distance * cos(angle);
    double y = startPoint.dy + distance * sin(angle);

    return Offset(x, y);
  }

  void _onHover(PointerHoverEvent event) {
    setState(() {
      NewTransitionProvider().hoveringState = widget.state;
    });
  }

  void _onEnter(PointerEnterEvent? event) {
    setState(() {
      _isHovered = true;
    });
  }

  void _onExit(PointerExitEvent? event) {
    setState(() {
      _isHovered = false;
    });
  }
}
