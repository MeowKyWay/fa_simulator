import 'dart:math';

import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/diagram_panel_body.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_drag_bar.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_menu.dart';
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

  final PageController _pageController = PageController(initialPage: 1);
  int _selectedIndex = 1;

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void _onDrag(double delta) {
    setState(() {
      _height = (_height - delta).clamp(2.5, widget.constraints.maxHeight);
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
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        height: _isExpanded ? max(_height, _expandedThreshold) : 5,
        child: Column(children: [
          DiagramPanelDragBar(
            onChange: _onDrag,
            maxHeight: 5,
            minHeight: 1,
          ),
          if (_isExpanded)
            DiagramPanelMenu(
              selectedIndex: _selectedIndex,
              onSelect: _onSelect,
            ),
          Expanded(
            child: Offstage(
              offstage: !_isExpanded,
              child: DiagramPanelBody(
                controller: _pageController,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
