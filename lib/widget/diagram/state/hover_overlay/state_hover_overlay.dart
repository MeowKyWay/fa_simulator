import 'dart:math';
import 'dart:developer' as developer;

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/clip/ring_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/diagram_draggable.dart';
import 'package:fa_simulator/widget/diagram/state/hover_overlay/state_hover_overlay_drag_target.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
import 'package:fa_simulator/widget/provider/keyboard_provider.dart';
import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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

  final GlobalKey _key = GlobalKey();

  bool _isHovered = false;
  bool _shouldShowHoverRing = false;

  @override
  Widget build(BuildContext context) {
    NewTransitionProvider provider = NewTransitionProvider();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (DiagramList().hoveringStateFlag) {
        DiagramList().hoveringStateFlag = false;
        DiagramList().hoveringStateId = "";
      }
    });

    _innerRadius = stateSize / 2 - _ringWidth;
    _outerRadius = stateSize / 2 + _ringWidth;

    return Consumer<KeyboardProvider>(
        builder: (context, keyboardProvider, child) {
      if (keyboardProvider.isShiftPressed) {
        _shouldShowHoverRing = provider.destinationState == widget.state &&
            provider.destinationStateCentered;
      } else {
        _shouldShowHoverRing =
            provider.destinationState == widget.state
                ? provider.destinationStateCentered
                : _isHovered;
      }
      return ClipPath(
        key: _key,
        clipper: RingClipper(
          innerRadius: _innerRadius,
          outerRadius: _outerRadius,
        ),
        child: StateHoverOverlayDragTarget(
          state: widget.state,
          child: Stack(
            children: [
              const DiagramDraggable(),
              NewTransitionDraggable(
                state: widget.state,
                child: MouseRegion(
                  onHover: _onHover,
                  onExit: _onExit,
                  onEnter: _onEnter,
                  child: Container(
                    width: stateSize + (_ringWidth * 2),
                    height: stateSize + (_ringWidth * 2),
                    color: _shouldShowHoverRing
                        ? Colors.green.withOpacity(0.75)
                        : Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Offset calculateNewPoint(Offset startPoint, double distance, double angle) {
    // Convert the angle to radians

    // Calculate the new x and y coordinates
    double x = startPoint.dx + distance * cos(angle);
    double y = startPoint.dy + distance * sin(angle);

    return Offset(x, y);
  }

  void _onHover(PointerHoverEvent event) {
    Offset bodyLocalPosition =
        BodyProvider().getBodyLocalPosition(event.position);
    double angle = (bodyLocalPosition - widget.state.position).direction;
    setState(() {
      NewTransitionProvider().hoveringState = widget.state;
      NewTransitionProvider().hoveringStateAngle = angle;
    });
  }

  void _onEnter(PointerEnterEvent? event) {
    setState(() {
      _isHovered = true;
    });
    DiagramList().hoveringStateFlag = false;
    if (!NewTransitionProvider().isDraggingNewTransition) {
      return;
    }
    if (NewTransitionProvider().sourceState == widget.state) {
      return;
    }
    developer.log("Hovering state: ${widget.state.id}");
    setState(() {
      NewTransitionProvider().destinationState = widget.state;
      NewTransitionProvider().destinationStateFlag = true;
    });
  }

  void _onExit(PointerExitEvent? event) {
    setState(() {
      _isHovered = false;
    });
    if (!DiagramList().hoveringStateFlag) {
      DiagramList().hoveringStateFlag = false;
      DiagramList().hoveringStateId = "";
    }
    // if (NewTransitionProvider().isHovering) {
    //   return;
    // }
    setState(() {
      if (NewTransitionProvider().destinationState == widget.state) {
        NewTransitionProvider().destinationState = null;
        NewTransitionProvider().destinationStateFlag = false;
      }
      if (NewTransitionProvider().hoveringState == widget.state) {
        NewTransitionProvider().hoveringState = null;
      }
    });
  }
}
