import 'package:flutter/material.dart';

class ZegZagBorder extends CustomPainter {
  ZegZagBorder(
      {this.borderHeight = 20,
      this.wDivisions = 10,
      this.hDivisions = 20,
      this.strokeWidth = 2});
  final double borderHeight;
  final double wDivisions;
  final double hDivisions;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    Paint p = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    double widthDiv = width / wDivisions;
    double heightDiv = height / hDivisions;
    Path path = Path();

    for (int i = 1; i <= wDivisions; i++) {
      if (i % 2 == 0) {
        path.lineTo(widthDiv * i, borderHeight);
      } else {
        path.lineTo(widthDiv * i, 0);
      }
    }

    for (int i = 0; i <= hDivisions; i++) {
      if (i % 2 == 0) {
        path.lineTo(width - borderHeight, heightDiv * i);
      } else {
        path.lineTo(width, heightDiv * i);
      }
    }

    for (int i = 1; i <= wDivisions; i++) {
      if (i % 2 == 0) {
        path.lineTo(width - (widthDiv * i), height - borderHeight);
      } else {
        path.lineTo(width - (widthDiv * i), height);
      }
    }

    for (int i = 1; i <= hDivisions; i++) {
      if (i % 2 == 0) {
        path.lineTo(borderHeight, height - (heightDiv * i));
      } else {
        path.lineTo(0, height - (heightDiv * i));
      }
    }

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
