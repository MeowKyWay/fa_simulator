import 'dart:developer';

import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';

class BodySingleton with ChangeNotifier {
  static final BodySingleton _instance = BodySingleton._internal(); //Singleton
  BodySingleton._internal();
  factory BodySingleton() {
    return _instance;
  }

  final GlobalKey _bodyKey = GlobalKey();
  GlobalKey get bodyKey => _bodyKey;
  //Position
  final GlobalKey _gestureDetectorKey = GlobalKey();
  GlobalKey get getGestureDetectorKey => _gestureDetectorKey;
  //DraggableOverlay local position
  final GlobalKey _draggableOverlayKey = GlobalKey();
  GlobalKey get getDraggableOverlayKey => _draggableOverlayKey;
  // Method to get the local position
  Offset getBodyLocalPosition(Offset position) {
    RenderBox renderBox =
        _gestureDetectorKey.currentContext?.findRenderObject() as RenderBox;

    // Convert the global position to local position
    Offset localPosition = renderBox.globalToLocal(position);
    return localPosition;
  }

  Offset getDraggableOverlayLocalPosition(Offset position) {
    RenderBox renderBox =
        _draggableOverlayKey.currentContext?.findRenderObject() as RenderBox;

    // Convert the global position to local position
    Offset localPosition = renderBox.globalToLocal(position);
    return localPosition;
  }

  Offset getDraggableOverlayPosition() {
    RenderBox renderBox =
        _draggableOverlayKey.currentContext?.findRenderObject() as RenderBox;

    // Convert the global position to local position
    Offset localPosition = getBodyLocalPosition(
      renderBox.localToGlobal(Offset.zero),
    );
    return localPosition;
  }

  Size getDraggableOverlaySize() {
    RenderBox renderBox =
        _draggableOverlayKey.currentContext?.findRenderObject() as RenderBox;

    return renderBox.size;
  }

  Offset getSnappedPosition(Offset position) {
    double x = position.dx;
    double y = position.dy;
    double snap = gridSize / subGridCount;
    x = (x / snap).round() * snap;
    y = (y / snap).round() * snap;
    return Offset(x, y);
  }

  bool isWithinBody(Offset globalPosition) {
    // Get the RenderBox of the widget using the global key
    RenderBox renderBox =
        _bodyKey.currentContext?.findRenderObject() as RenderBox;

    // Convert the global position to a local position relative to the widget
    Offset localPosition = renderBox.globalToLocal(globalPosition);

    // Log the bounds of the widget for debugging
    log(renderBox.paintBounds.toString());

    // Check if the local position is within the widget's bounds
    return renderBox.paintBounds.contains(localPosition);
  }
}
