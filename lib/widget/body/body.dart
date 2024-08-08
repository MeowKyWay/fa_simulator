import 'dart:developer';

import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/state_list.dart';
import 'package:fa_simulator/widget/body/grid_painter.dart';
import 'package:fa_simulator/widget/body/zoomable_container.dart';
import 'package:fa_simulator/widget/diagram/diagram_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double scale = 1.0;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final GlobalKey _gestureDetectorKey = GlobalKey();
  final TransformationController _transformationController =
      TransformationController();

  void _updateScale(double newScale) {
    if (scale == newScale) return;
    setState(() {
      scale = newScale;
    });
  }

  Offset _getDragEndLocalPosition(Offset position) {
    RenderBox renderBox =
        _gestureDetectorKey.currentContext?.findRenderObject() as RenderBox;

    // Convert the global position to local position
    Offset localPosition = renderBox.globalToLocal(position);
    return localPosition;
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
              Consumer<StateList>(builder: (context, stateList, child) {
                return GestureDetector(
                  key: _gestureDetectorKey,
                  onTapDown: (TapDownDetails details) {
                    setState(() {
                      stateList.addState(details.localPosition);
                    });
                  },
                );
              }),
              Consumer<StateList>(builder: (context, stateList, child) {
                return Stack(children: [
                  ...stateList.states.map((state) {
                    return DiagramStateWidget(
                      position: state.position,
                      name: state.name,
                      onDelete: () => stateList.deleteState(state.name),
                      onRename: (newName) =>
                          stateList.renameState(state.name, newName),
                      onDragEnd: (position) => stateList.moveState(
                          state.name, _getDragEndLocalPosition(position)),
                    );
                  }),
                ]);
              })
            ],
          ),
        ),
      ),
    );
  }
}
