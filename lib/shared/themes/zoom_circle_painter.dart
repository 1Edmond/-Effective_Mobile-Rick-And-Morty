import 'package:flutter/material.dart';

class ZoomCirclePainter extends CustomPainter {
  final double animation;
  final Offset center;
  final Size screenSize;
  final Color color;

  ZoomCirclePainter({
    required this.animation,
    required this.center,
    required this.screenSize,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withAlpha((255 * 0.7).toInt())
      ..style = PaintingStyle.fill;


    final maxDistance = [
      center.distance,
      (center - Offset(screenSize.width, 0)).distance,
      (center - Offset(0, screenSize.height)).distance,
      (center - Offset(screenSize.width, screenSize.height)).distance,
    ].reduce((a, b) => a > b ? a : b);


    final progress = Curves.easeInOut.transform(animation);
    final radius = maxDistance * progress;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(ZoomCirclePainter oldDelegate) =>
      oldDelegate.animation != animation ||
          oldDelegate.center != center;
}