
import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/data/databases/character_database.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_data_source.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_local_data_source.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_remote_data_source.dart';
import 'package:rick_and_morty/features/characters/domains/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domains/usecases/get_all_characters.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/features/characters/presentation/controllers/characters_fav_list_screens_controller.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/characters_list_screens_controller.dart';
import 'package:rick_and_morty/features/characters/presentation/interfaces/characters_screem_interface.dart';
import 'package:rick_and_morty/shared/themes/theme_controller.dart';

class DIService {

  static CharactersScreemInterface getDependency({String? tag = ""}) {
    return tag == "list" ? Get.find<CharactersListScreensController>(tag: tag)
          : Get.find<CharactersFavListScreensController>(tag: tag);
  }

  static Future<void> init() async {


    Get.put<http.Client>(http.Client(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<CharacterDatabase>(CharacterDatabase(), permanent: true);

    Get.lazyPut<CharactersLocalDataSource>(
          () => CharactersLocalDataSourceImpl(Get.find()),
      fenix: true,
    );



    Get.lazyPut<CharactersRemoteDataSource>(
          () => CharactersRemoteDataSourceImpl(client: Get.find()),
      fenix: true,
    );
    Get.lazyPut<CharactersRepository>(
          () => CharactersRepositoryImpl(
        localDataSource: Get.find(),
        remoteDataSource: Get.find(),
      ),
      fenix: true,
    );

    Get.put<GetAllCharacters>(GetAllCharacters(Get.find<CharactersRepository>()),
      permanent: true,
    );

    Get.put<CharactersFavListScreensController>(CharactersFavListScreensController());

    Get.put<CharactersFavListScreensController>(
      CharactersFavListScreensController(),
      permanent: true,
      tag: 'fav',
    );
    Get.put<CharactersListScreensController>(
      CharactersListScreensController(),
      tag: 'list',
      permanent: true,
    );

  }
}