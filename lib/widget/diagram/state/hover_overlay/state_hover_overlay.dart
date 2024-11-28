import 'dart:math';
import 'dart:developer' as developer;

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/clip/ring_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/diagram_draggable.dart';
import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
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

  final GlobalKey _key = GlobalKey();

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

    return ClipPath(
      key: _key,
      clipper: RingClipper(
        innerRadius: _innerRadius,
        outerRadius: _outerRadius,
      ),
      child: DragTarget(
          onWillAcceptWithDetails: (DragTargetDetails details) {
            if (details.data is NewTransitionType) {
              if ((details.data as NewTransitionType).from.id ==
                  widget.state.id) {
                return false;
              }
              return true;
            }
            return false;
          },
          onAcceptWithDetails: (details) {
            StateType state = (details.data as NewTransitionType).from;
            developer.log(state.id);
          },
          onLeave: (details) {
          },
          hitTestBehavior: HitTestBehavior.translucent,
          builder: (context, candidateData, rejectedData) {
            return Stack(
              children: [
                const DiagramDraggable(),
                NewTransitionDraggable(
                  state: widget.state,
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
              ],
            );
          }),
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
    Offset bodyLocalPosition =
        BodyProvider().getBodyLocalPosition(event.position);
    double angle = (bodyLocalPosition - widget.state.position).direction;
    setState(() {
      NewTransitionProvider().hoveringState = widget.state;
      NewTransitionProvider().hoveringStateAngle = angle;
    });
  }

  void _onEnter(PointerEnterEvent? event) {
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
