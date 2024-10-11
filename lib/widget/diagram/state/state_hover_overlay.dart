import 'dart:developer';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/clip/ring_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
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
  final double _ringWidth = 5.0;
  late double _innerRadius;
  late double _outerRadius;
  late Offset _center;
  late Offset _localCenter;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (DiagramList().hoveringStateFlag) {
        DiagramList().hoveringStateFlag = false;
        DiagramList().hoveringStateId = "";
      }
    });

    _center = Offset(
      widget.state.position.dx - stateSize / 2,
      widget.state.position.dy - stateSize / 2,
    );

    _innerRadius = stateSize / 2 - _ringWidth;
    _outerRadius = stateSize / 2 + _ringWidth;
    _localCenter = const Offset(stateSize / 2, stateSize / 2);

    return Positioned(
      left: _center.dx - _ringWidth,
      top: _center.dy - _ringWidth,
      child: ClipPath(
        clipper: RingClipper(
          innerRadius: _innerRadius,
          outerRadius: _outerRadius,
        ),
        child: MouseRegion(
          onHover: _onHover,
          onExit: _onExit,
          onEnter: _onEnter,
          child: Container(
            width: stateSize + (_ringWidth * 2),
            height: stateSize + (_ringWidth * 2),
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  void _onHover(PointerHoverEvent event) {
    double angle = (event.localPosition - _localCenter).direction;
    log("Hover: $angle");
  }

  void _onEnter(PointerEnterEvent event) {
    DiagramList().hoveringStateFlag = false;
  }

  void _onExit(PointerExitEvent event) {
    if (!DiagramList().hoveringStateFlag) {
      DiagramList().hoveringStateFlag = false;
      DiagramList().hoveringStateId = "";
    }
  }
}
