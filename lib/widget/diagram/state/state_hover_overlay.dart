import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StateHoverOverlay extends StatefulWidget {
  final double angle;

  const StateHoverOverlay({
    super.key,
    required this.angle,
  });

  @override
  State<StateHoverOverlay> createState() => _StateHoverOverlayState();
}

class _StateHoverOverlayState extends State<StateHoverOverlay> {

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: stateSize,
        height: stateSize,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void onPointerHover(PointerHoverEvent event) {
    log('StateHoverOverlay onHover');
  }
}
