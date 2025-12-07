import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/base_character_list_controller.dart';

class CharactersListScreensController extends BaseCharacterListController {

  Future<void> loadCharacters() async {
    if (isLoading.value) return;

    isLoading.value = true;

    await loadData();

    characters.assignAll(allCharacters.take(pageCount.value));


    isLoading.value = false;

  }

  Future<void> loadNextPage() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      var tempData =  allCharacters.skip(characters.length).take(pageCount.value);
      characters.addAll(tempData);
    } catch (e) { }

    isLoading.value = false;

    if(characters.length == allCharacters.length){
      await loadData();
    }
  }
}