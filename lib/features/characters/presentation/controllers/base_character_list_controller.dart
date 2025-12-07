import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/data/databases/character_database.dart';
import 'package:rick_and_morty/features/characters/domains/usecases/get_all_characters.dart';
import 'package:rick_and_morty/features/characters/presentation/interfaces/characters_screem_interface.dart';

class BaseCharacterListController extends CharactersScreemInterface {

  final GetAllCharacters getAllCharacters = Get.find<GetAllCharacters>();
  final CharacterDatabase characterDatabase = Get.find<CharacterDatabase>();


  @override
  bool isFavorite(int characterId) {
    return favorites.isNotEmpty && favorites.contains(characterId);
  }



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    characters.clear();
    favorites.clear();
    allCharacters.clear();

    super.onClose();
  }

  @override
  Future<void> toggleFavorite(int characterId) async {
    if (isFavorite(characterId)) {
      favorites.remove(characterId);
      await characterDatabase.removeFavorite(characterId);
    }
    else {
      favorites.add(characterId);
      await characterDatabase.addFavorite(characterId);
    }
    update();
  }

  Future<void> loadFavoritesData() async {
    var favoritesData = await characterDatabase.getFavorites();
    favorites.assignAll(favoritesData);
  }

  Future<void> loadData() async {
    if(characters.isNotEmpty && characters.length == allCharacters.length){
      response = await getAllCharacters.call(response!.nextPage);
    }
    else{
      response = await getAllCharacters.call();
    }

    allCharacters.addAll(response!.data);
  }





}