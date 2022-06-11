import 'package:firstcleanarchi/infrastructur/datasources/theme_local_datasource.dart';
import 'package:firstcleanarchi/infrastructur/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  //Was wird reinkommen?
  late ThemeLocalDataSource themelocalDatasource;
  late MockSharedPreferences mockSharedPreferences;

  //Depenency zuweisen
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themelocalDatasource =
        ThemeLocalDatasourceImpl(sharedPreferences: mockSharedPreferences);
  });
  group('getCachedThemeData', (() {
    final t_themeData = true;

    test(
        'Should return a bool (ThemeData) if there is one in sharedPreferences',
        () async {
      // arrange
      //Wenn SharedPreferences mit irgendeinem Key gecallt wird
      when(mockSharedPreferences.getBool(any)).thenReturn(t_themeData);
      // act
      final result = await themelocalDatasource.getLastTheme();
      // assert
      //Prüfen: Wird das eigentlich gecallt?
      verify(mockSharedPreferences.getBool(CACHED_THEME_MODE));
      expect(result, t_themeData);
    });
    //Failure
    test('Should return a CacheException if there is no in sharedPreferences',
        () async {
      // arrange
      //Wenn SharedPreferences mit irgendeinem Key gecallt wird
      when(mockSharedPreferences.getBool(any)).thenReturn(null);
      // act
      final call = themelocalDatasource.getLastTheme;
      // assert
      //Prüfen: Wird das eigentlich gecallt?
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  }));

  group('cacheTheme', () {
    final t_themeData = true;

    //wird es überhaupt aufgerufen
    test('should call shared preferences to cache theme mode', () async {
      // arrange
      //Wenn wir future haben(setbool) => thenAnswer anstatt thenReturn
      when(mockSharedPreferences.setBool(any, any))
          .thenAnswer((_) async => true);
      // act
      await themelocalDatasource.cacheTheme(mode: t_themeData);
      // assert
      verify(mockSharedPreferences.setBool(CACHED_THEME_MODE, t_themeData));
    });
  });
}
