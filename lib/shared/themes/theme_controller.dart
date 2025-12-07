import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rick_and_morty/shared/themes/theme_data.dart';

class ThemeController extends GetxController with GetSingleTickerProviderStateMixin {
  static const String _themeKey = 'isDarkMode';

  final RxBool isDark = false.obs;
  final RxBool isAnimating = false.obs;
  final _box = GetStorage();

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    _loadSavedTheme();
    _updateSystemUIOverlay();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void _loadSavedTheme() {
    final savedTheme = _box.read<bool>(_themeKey);

    if (savedTheme != null) {
      isDark.value = savedTheme;
    } else {
      final platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      isDark.value = platformBrightness == Brightness.dark;
    }

    Get.changeTheme(isDark.value ? darkTheme : lightTheme);
    _updateSystemUIOverlay();
  }

  void _updateSystemUIOverlay() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark.value ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark.value ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: isDark.value ? Colors.black : Colors.white,
        systemNavigationBarIconBrightness: isDark.value ? Brightness.light : Brightness.dark,
      ),
    );
  }

  Future<void> toggleTheme() async {
    if (isAnimating.value) return;

    isAnimating.value = true;

    isDark.value = !isDark.value;
    Get.changeTheme(isDark.value ? darkTheme : lightTheme);
    _updateSystemUIOverlay();
    _saveTheme();

    await animationController.forward();

    animationController.reset();
    isAnimating.value = false;
  }

  void _saveTheme() {
    _box.write(_themeKey, isDark.value);
  }


}