import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/characters_list_screens_controller.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_item.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_loading_indicator.dart';

class CharactersListScreens extends StatefulWidget {
  const CharactersListScreens({super.key});

  @override
  State<CharactersListScreens> createState() => _CharactersListScreensState();
}

class _CharactersListScreensState extends State<CharactersListScreens> with WidgetsBindingObserver {
  late CharactersListScreensController characterController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);


    characterController = Get.find<CharactersListScreensController>(tag: "list");


    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        characterController.loadNextPage();
      }
    });


    characterController.loadCharacters().then(
        (r) {
          characterController.loadFavoritesData();
        }
    );
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //
  //   if (state == AppLifecycleState.resumed) {
  //     characterController.loadCharacters();
  //   }
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Obx(() => Visibility(
                  visible: characterController.characters.isNotEmpty
                        && !characterController.isLoading.value,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: characterController.characters.length,
                    itemBuilder: (context, index) {
                      final character = characterController.characters[index];
                      return CharactersItem(
                        title: character.name,
                        imageUrl: character.image,
                        tag: character.gender,
                        type: character.type,

                        isAnimationEnable: true,
                        characterId: character.id,
                      );
                    },
                  ),
                )),
              ),
            ],
          ),
          Obx(() => Visibility(
            visible: characterController.isLoading.value,
            child: CharacterLoadingIndicator(),
          )),
        ],
      ),
    );
  }
}
