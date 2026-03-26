import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final bool reverse;

  WaveClipper({this.reverse = false});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (reverse) {
      // For English/LTR: The curve is on the right side
      path.moveTo(0, size.height);
      path.lineTo(0, 0); // Straight line up the left side
      // The magic curve:
      path.cubicTo(
        size.width * 0.2,
        0, // First control point (start horizontal)
        size.width * 0.8,
        size.height * 0.1, // Second control point (smooth entry)
        size.width,
        size.height, // End point
      );
    } else {
      // For Arabic/RTL: The curve is on the left side
      path.moveTo(size.width, size.height);
      path.lineTo(size.width, 0); // Straight line up the right side
      // Smooth curve back to the bottom left
      path.cubicTo(
        size.width * 0.8,
        0,
        size.width * 0.2,
        size.height * 0.1,
        0,
        size.height,
      );
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class PickupTagPainter extends CustomPainter {
  final Color color;
  final bool isArabic;

  PickupTagPainter({required this.color, required this.isArabic});

  @override
  void paint(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = const Color(0x1F000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final path = Path();

    // The 'curveWidth' determines how much space the wave takes.
    // Increase this value to make the transition longer and smoother.
    double curveWidth = 30.0;

    if (isArabic) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width - curveWidth, 0);

      // DEEP CURVE LOGIC
      path.cubicTo(
        size.width - (curveWidth * 0.6),
        0, // Starts flat longer
        size.width - (curveWidth * 0.4),
        size.height, // Dives deep into the corner
        size.width,
        size.height, // Ends at the tail
      );
    } else {
      path.moveTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(curveWidth, 0);

      path.cubicTo(
        curveWidth * 0.4,
        0,
        curveWidth * 0.1,
        size.height,
        0,
        size.height,
      );
    }

    path.close();

    canvas.save();
    canvas.translate(-1, -1);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    final mainPaint = Paint()..color = color;
    canvas.drawPath(path, mainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
