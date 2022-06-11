import 'package:firstcleanarchi/infrastructur/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_THEME_MODE = 'CACHED_THEME_MODE';

abstract class ThemeLocalDataSource {
  //Schreiben und Lesen vom Handy dauert => Future
  Future<bool> getLastTheme();
  Future<void> cacheTheme({required bool mode});
}

class ThemeLocalDatasourceImpl implements ThemeLocalDataSource {
  //Haben eine Abhängigkeit von SharedPreferences
  final SharedPreferences sharedPreferences;
  //Konstruktor für die Tests
  ThemeLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheTheme({required bool mode}) {
    return sharedPreferences.setBool(CACHED_THEME_MODE, mode);
  }

  @override
  Future<bool> getLastTheme() {
    final bool? mode = sharedPreferences.getBool(CACHED_THEME_MODE);

    if (mode != null) {
      return Future.value(mode);
    } else {
      throw CacheException();
    }
  }
}
