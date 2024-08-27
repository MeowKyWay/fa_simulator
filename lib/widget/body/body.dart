import 'dart:developer';

import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/state_list.dart';
import 'package:fa_simulator/widget/body/input/body_gesture_detector.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/body/decoration/grid_painter.dart';
import 'package:fa_simulator/widget/body/selection_box.dart';
import 'package:fa_simulator/widget/body/zoomable_container.dart';
import 'package:fa_simulator/widget/diagram/state_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final TransformationController _transformationController =
      TransformationController();

  void _updateScale(double newScale) {
    if (scale == newScale) return;
    setState(() {
      scale = newScale;
    });
  }

  @override
  void initState() {
    super.initState();
    KeyboardSingleton().requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BodyKeyboardListener(
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
                const BodyGestureDetector(),
                const SelectionBox(),
                Consumer<StateList>(builder: (context, stateList, child) {
                  return Stack(children: [
                    ...stateList.states.map((state) {
                      return StateNode(
                        state: state,
                      );
                    }),
                  ]);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
