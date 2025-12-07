import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/shared/themes/theme_controller.dart';
import 'package:rick_and_morty/shared/themes/zoom_circle_painter.dart';

class ThemeRippleOverlay extends StatelessWidget {
  final Offset? center;

  const ThemeRippleOverlay({
    Key? key,
    this.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>();

    return Obx(() {
      if (!controller.isAnimating.value) {
        return const SizedBox.shrink();
      }

      final size = MediaQuery.of(context).size;

      return AnimatedBuilder(
        animation: controller.animation,
        builder: (context, child) {
          return Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: ZoomCirclePainter(
                  animation: controller.animation.value,
                  center: center ?? Offset(size.width / 2, size.height / 2),
                  screenSize: size,
                  color: controller.isDark.value ? Colors.black : Colors.white,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}