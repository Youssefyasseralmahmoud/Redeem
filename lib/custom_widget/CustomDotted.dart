import 'package:flutter/material.dart';
import 'package:redeem/theme/colors.dart';

class CustomDrawDottedhorizontalline extends CustomPainter {
  Color? painerColor;
  late Paint p;
  CustomDrawDottedhorizontalline() {
    {
      this.painerColor;
      p = Paint();
      p.color =
          Colors.white; //dots color
      p.strokeWidth = 2; //dots thickness
      p.strokeCap = StrokeCap.square; //dots corner edges
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0)
        canvas.drawLine(Offset(i, 0.0), Offset(i + 10, 0.0), p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}