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
                  key: BodyKey().globalKey,
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
                      state: state,
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

class BodyKey {

  static final BodyKey _instance = BodyKey._internal(); //Singleton
  BodyKey._internal();
  factory BodyKey() {
    return _instance;
  }

  final GlobalKey globalKey = GlobalKey();

  // Method to get the local position
  Offset getBodyLocalPosition(Offset position) {
    RenderBox renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;

    // Convert the global position to local position
    Offset localPosition = renderBox.globalToLocal(position);
    return localPosition;
  }
}
