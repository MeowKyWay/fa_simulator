import 'dart:math';

import 'package:fa_simulator/config/config.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/diagram_panel_body.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_drag_bar.dart';
import 'package:flutter/material.dart';

class DiagramPanel extends StatefulWidget {
  final BoxConstraints constraints;

  const DiagramPanel({
    super.key,
    required this.constraints,
  });

  @override
  State<DiagramPanel> createState() => _DiagramPanelState();
}

class _DiagramPanelState extends State<DiagramPanel> {
  double _height = 100;
  final double _expandedThreshold = 75;
  final double _collapsedThreshold = 25;
  bool _isExpanded = true;

  void _onDrag(double delta) {
    setState(() {
      _height = (_height - delta).clamp(2.5, bodySize.height);
      if (_height <= _collapsedThreshold) {
        _isExpanded = false;
      } else if (_height >= _expandedThreshold) {
        _isExpanded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: widget.constraints,
      child: SizedBox(
        height: _isExpanded ? max(_height, _expandedThreshold) : 5,
        child: Column(
          children: [
            DiagramPanelDragBar(
              onChange: _onDrag,
              maxHeight: 5,
              minHeight: 1,
            ),
            if (_isExpanded) ...[
              Container(
                height: 25,
                width: bodySize.width,
                color: Theme.of(context).colorScheme.primary,
              ),
              DiagramPanelBody(),
            ]
          ],
        ),
      ),
    );
  }
}
