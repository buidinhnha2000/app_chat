import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

double deg2rad(double deg) => deg * math.pi / 180;

double rad2deg(double rad) => rad * 180 / math.pi;

class CircleBorderWith4Color extends CustomPainter {
  final double borderThinckNess;
  final double gap;

  final Color bottomRightColor;
  final Color bottomLeftColor;
  final Color topRightColor;
  final Color topLeftColor;

  CircleBorderWith4Color({
    required this.gap,
    required this.borderThinckNess,
    required this.bottomLeftColor,
    required this.bottomRightColor,
    required this.topLeftColor,
    required this.topRightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    Paint paintTr = Paint()
      ..color = topRightColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckNess;

    Paint paintBr = Paint()
      ..color = bottomRightColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckNess;

    Paint paintBl = Paint()
      ..color = bottomLeftColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckNess;

    Paint paintTl = Paint()
      ..color = topLeftColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckNess;

    canvas.drawArc(Rect.fromCenter(center: center, width: size.width, height: size.height), deg2rad(45 + gap), deg2rad(90 - (gap * 2)),
        false, paintBr);

    canvas.drawArc(Rect.fromCenter(center: center, width: size.width, height: size.height), deg2rad(135 + gap), deg2rad(90 - (gap * 2)),
        false, paintBl);

    canvas.drawArc(Rect.fromCenter(center: center, width: size.width, height: size.height), deg2rad(225 + gap), deg2rad(90 - (gap * 2)),
        false, paintTl);

    canvas.drawArc(Rect.fromCenter(center: center, width: size.width, height: size.height), deg2rad(315 + gap), deg2rad(90 - (gap * 2)),
        false, paintTr);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
