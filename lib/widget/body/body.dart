import 'dart:developer';

import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/widget/body/grid_painter.dart';
import 'package:fa_simulator/widget/body/zoomable_container.dart';
import 'package:fa_simulator/widget/diagram/diagram_state.dart';
import 'package:flutter/material.dart';

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
  final TransformationController _transformationController =
      TransformationController();

  void _addState(Offset position) {
    setState(() {
      DiagramState state = DiagramState(
        position: position - const Offset(stateSize / 2, stateSize / 2),
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
  void _renameState(String name, String newName) {
    setState(() {
      for (var i = 0; i < _states.length; i++) {
        if (_states[i].name == name) {
          _states[i].name = newName;
        }
      }
    });
  }

  void _updateScale(double newScale) {
    if (scale == newScale) return;
    setState(() {
      scale = newScale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ZoomableContainer(
        onScaleChange: _updateScale,
        transformationController: _transformationController,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              CustomPaint(
                size: size,
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
                    onRename: (String newName) {
                      _renameState(state.name, newName);
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
