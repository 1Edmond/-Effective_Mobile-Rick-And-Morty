import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/base_character_list_controller.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/characters_list_screens_controller.dart';

class CharactersFavListScreensController extends BaseCharacterListController {
  late CharactersListScreensController characterController;

  @override
  void onInit() async {
    try{
      await loadFavoritesData();
      var data = await characterDatabase.getAllCharacters();
      allCharacters = data.where(
              (x) => isFavorite(x.id)).toList();
    }
    catch(e){
      print(e);
    }

    super.onInit();
  }

  Future<void> loadFavoritesCharacters() async {
    if (isLoading.value) return;
    isLoading.value = true;

    await changeOrder(allCharacters, currentOrder.value);
    characters.assignAll(allCharacters.take(pageCount.value));

    isLoading.value = false;
  }

  Future<void> loadNextPage() async {
    if (isLoading.value || characters.length < pageCount.value) return;
    isLoading.value = true;

    try {
      var tempData =  allCharacters.skip(characters.length).take(pageCount.value).toList();
      characters.addAll(tempData);
    } catch (e) { }

    isLoading.value = false;
  }

  Future<void> order() async{
    currentOrder.value = currentOrder.value == "name" ? "gender" : "name";
    await loadFavoritesCharacters();
  }

  @override
  Future<void> toggleFavorite(int characterId) async {
    await super.toggleFavorite(characterId);
    await loadFavoritesCharacters();
  }

  Future<void> changeOrder(List<CharacterModel> data, String order) async {
    if(order == "gender"){
      data.sort((a,b) => a.gender.compareTo(b.gender));
    }
    else{
      data.sort((a,b) => a.name.compareTo(b.name));
    }
  }
}