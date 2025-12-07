import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/shared/themes/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>();

    return Obx(() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return RotationTransition(
          turns: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: IconButton(
        key: ValueKey(controller.isDark.value),
        icon: Icon(
          controller.isDark.value ? Icons.light_mode : Icons.dark_mode,
          color: controller.isDark.value ? Colors.amber : Colors.orange,
        ),
        onPressed: () => controller.toggleTheme(),
      ),
    ));
  }
}