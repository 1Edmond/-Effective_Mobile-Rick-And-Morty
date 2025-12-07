import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/characters_fav_list_screens_controller.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_fav_screens.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_list_screens.dart';
import 'package:rick_and_morty/shared/themes/theme_toggle_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _index = 0;
  final pages = [
    CharactersListScreens(),
    CharactersFavListScreens(),
  ];

  @override
  Widget build(BuildContext context) {

    final favListController = Get.find<CharactersFavListScreensController>(tag: "fav");

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: _index,
          animationDuration: Duration(milliseconds: 500),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor ?? Colors.blueAccent,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.favorite, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
        appBar: AppBar(
          title: const Text(
            'Rick And Morty',
          ),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child:  _index == 1 ? GestureDetector(
                onTap: () {
                  favListController.order();
                },
                child: Obx(() => Icon(
                  favListController.currentOrder.value == "name" ? Icons.abc:
                  favListController.currentOrder.value == "gender" ? Icons.tag:
                  null,
                  size: 28,
                )),
              ) : Container(),
            )
          ],
        ),
        body: pages[_index],
        floatingActionButton: ThemeToggleButton(),
    );
  }
}
