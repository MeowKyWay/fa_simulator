import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double gridSpacing;
  final Color primary;
  final Color secondary;

  GridPainter({
    this.gridSpacing = gridSize,
    required this.primary,
    required this.secondary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final primaryPaint = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final secondaryPaint = Paint()
      ..color = secondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw vertical grid lines
    for (double x = 0; x < size.width; x += gridSpacing / subGridCount) {
      if (x % gridSpacing == 0) {
        continue;
      }
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), secondaryPaint);
    }

    // Draw horizontal grid lines
    for (double y = 0; y < size.height; y += gridSpacing / subGridCount) {
      if (y % gridSpacing == 0) {
        continue;
      }
      canvas.drawLine(Offset(0, y), Offset(size.width, y), secondaryPaint);
    }

    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), primaryPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), primaryPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
