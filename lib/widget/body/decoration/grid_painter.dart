import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double gridSpacing;
  final Color gridColor;

  GridPainter(
      {this.gridSpacing = gridSize,
      this.gridColor = const Color.fromARGB(255, 200, 200, 200)});

  @override
  void paint(Canvas canvas, Size size) {
    final primaryPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final secondaryPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw vertical grid lines
    for (double x = 0; x < size.width; x += gridSpacing / 5) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height),
          (x % gridSpacing == 0) ? primaryPaint : secondaryPaint);
    }

    // Draw horizontal grid lines
    for (double y = 0; y < size.height; y += gridSpacing / 5) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y),
          (y % gridSpacing == 0) ? primaryPaint : secondaryPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
