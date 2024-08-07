import 'dart:developer';

import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/widget/body/grid_painter.dart';
import 'package:fa_simulator/widget/body/zoomable_container.dart';
import 'package:fa_simulator/widget/diagram/diagram_state.dart';
import 'package:flutter/material.dart';

const Size _size = Size(7680, 4320);
double scale = 1.0;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final List<DiagramState> _states = [];
  final GlobalKey _gestureDetectorKey = GlobalKey();

  void _addState(Offset position) {
    setState(() {
      DiagramState state = DiagramState(
        position: position - Offset(stateSize / 2, stateSize / 2),
        name: stateCounter.toString(),
      );
      _states.add(state);
      stateCounter++;
    });
  }

  void _deleteState(String name) {
    setState(() {
      _states.removeWhere((element) => element.name == name);
      FocusScope.of(context).unfocus();
    });
  }

  void _updateScale(double newScale) {
    setState(() {
      scale = newScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ZoomableContainer(
        onScaleChange: _updateScale,
        child: SizedBox(
          width: _size.width,
          height: _size.height,
          child: Stack(
            children: [
              CustomPaint(
                size: _size,
                painter: GridPainter(),
              ),
              GestureDetector(
                key: _gestureDetectorKey,
                onTapDown: (TapDownDetails details) {
                  setState(() {
                    _addState(details.localPosition);
                  });
                },
              ),
              ..._states.map((state) {
                return DiagramStateWidget(
                    position: state.position,
                    name: state.name,
                    onDelete: () {
                      _deleteState(state.name);
                    },
                    onDragEnd: (position) {
                      RenderBox renderBox = _gestureDetectorKey.currentContext
                          ?.findRenderObject() as RenderBox;

                      // Convert the global position to local position
                      Offset localPosition = renderBox.globalToLocal(position);

                      setState(() {
                        state.position = localPosition;
                      });
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
