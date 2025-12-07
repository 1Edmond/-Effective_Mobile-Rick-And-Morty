import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rick_and_morty/features/home_page.dart';
import 'package:rick_and_morty/shared/services/di_service.dart';
import 'package:rick_and_morty/shared/themes/theme_controller.dart';
import 'package:rick_and_morty/shared/themes/theme_data.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:rick_and_morty/shared/themes/theme_ripple_overlay.dart';


var isDarkMode = false;

void main() async  {

  WidgetsFlutterBinding.ensureInitialized();
  timeDilation = 3.0;
  await DIService.init();
  await GetStorage.init();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      title: 'Rick And Morty',
      debugShowCheckedModeBanner: false,
      theme: themeController.isDark.value
          ? darkTheme
          : lightTheme,
      home: Stack(
        children: [
          const HomePage(),
          const ThemeRippleOverlay(),
        ],
      ),
    ));
  }
}
