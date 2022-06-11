import 'package:dartz/dartz.dart';
import 'package:firstcleanarchi/domain/failrues/failures.dart';
import 'package:firstcleanarchi/domain/repositories/theme_repository.dart';
import 'package:firstcleanarchi/infrastructur/datasources/theme_local_datasource.dart';
import 'package:firstcleanarchi/infrastructur/exceptions/exceptions.dart';
import 'package:firstcleanarchi/infrastructur/repositories/theme_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([ThemeLocalDataSource])
void main() {
  late MockThemeLocalDataSource mockThemeLocalDataSource;
  late ThemeRepository themeRepository;

  //Zum testen von ChangeNotifier
  late int listenerCount;
  //Zuweisungen
  setUp(() {
    listenerCount = 0;
    mockThemeLocalDataSource = MockThemeLocalDataSource();
    themeRepository =
        ThemeRepositoryImpl(themeLocalDataSource: mockThemeLocalDataSource);
  });

  group('SetThemeMode', () {
    final t_themeMode = true;

    test('should call function to cache theme mode on local datasource', () {
      //arrange
      //wenn irgendein Mode gesetzt wird, dann wird Funktion ausgeführt => Test true
      when(mockThemeLocalDataSource.cacheTheme(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);
      //act
      themeRepository.setThemeMode(mode: t_themeMode);
      //assert
      verify(mockThemeLocalDataSource.cacheTheme(mode: t_themeMode));
    });
  });

  group('getThemeMode', () {
    final t_themeMode = true;

    test('should return theme mode if cached data is present', () async {
      //arrange
      when(mockThemeLocalDataSource.getLastTheme())
          .thenAnswer((_) async => t_themeMode);
      //act
      //Nicht nur ausgeführt sondern wollen es in einer Variable speichern
      final result = await themeRepository.getThemeMode();
      //assert
      expect(result, Right(t_themeMode));
      verify(mockThemeLocalDataSource.getLastTheme());
      verifyNoMoreInteractions(mockThemeLocalDataSource);
    });

    test(
        'should return CacheFailure if local datasource throws a cache exception',
        () async {
      //arrange
      when(mockThemeLocalDataSource.getLastTheme()).thenThrow(CacheException());
      //act
      //Nicht nur ausgeführt sondern wollen es in einer Variable speichern
      final result = await themeRepository.getThemeMode();
      //assert
      expect(result, Left(CacheFailure()));
      verify(mockThemeLocalDataSource.getLastTheme());
      verifyNoMoreInteractions(mockThemeLocalDataSource);
    });
  });
}
