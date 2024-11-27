import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/clip/ring_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/diagram_draggable.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_button.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_button_singleton.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
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
  late Offset _localCenter;

  Offset? _floatingButtonPosition = null;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (DiagramList().hoveringStateFlag) {
        DiagramList().hoveringStateFlag = false;
        DiagramList().hoveringStateId = "";
      }
    });

    _innerRadius = stateSize / 2 - _ringWidth;
    _outerRadius = stateSize / 2 + _ringWidth;

    _localCenter =
        Offset(stateSize / 2 + _ringWidth, stateSize / 2 + _ringWidth);

    return ClipPath(
      clipper: RingClipper(
        innerRadius: _innerRadius,
        outerRadius: _outerRadius,
      ),
      child: Stack(
        children: [
          const DiagramDraggable(),
          NewTransitionDraggable(
            data: widget.state,
            child: MouseRegion(
              onHover: _onHover,
              onExit: _onExit,
              onEnter: _onEnter,
              child: SizedBox(
                width: stateSize + (_ringWidth * 2),
                height: stateSize + (_ringWidth * 2),
              ),
            ),
          ),
          if (_floatingButtonPosition != null)
            NewTransitionButton(position: _floatingButtonPosition!),
        ],
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
    double angle = (event.localPosition - _localCenter).direction;
    Offset newPoint = calculateNewPoint(_localCenter, stateSize / 2, angle);
    setState(() {
      NewTransitionButtonSingleton().position = newPoint;
      _floatingButtonPosition = newPoint;
    });
  }

  void _onEnter(PointerEnterEvent event) {
    DiagramList().hoveringStateFlag = false;
  }

  void _onExit(PointerExitEvent event) {
    if (!DiagramList().hoveringStateFlag) {
      DiagramList().hoveringStateFlag = false;
      DiagramList().hoveringStateId = "";
    }
    if (NewTransitionButtonSingleton().isHovering) {
      return;
    }
    setState(() {
      NewTransitionButtonSingleton().position = null;
      _floatingButtonPosition = null;
    });
  }
}
