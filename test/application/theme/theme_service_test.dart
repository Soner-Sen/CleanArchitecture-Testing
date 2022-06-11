import 'package:firstcleanarchi/application/advicer/theme/theme_service.dart';
import 'package:firstcleanarchi/domain/repositories/theme_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_service_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  late MockThemeRepository mockThemeRepository;
  late ThemeService themeService;

  setUp(() {
    mockThemeRepository = MockThemeRepository();
    themeService = ThemeServiceImpl(
      themeRepository: mockThemeRepository,
    );
  });

  test('check if default value for darkmode is true', () {
    expect(themeService.isDarkModeOn, true);
  });

  group('setThemeMode', () {
    final t_mode = false;

    test(
        'should set the theme to the parameter it gets  and store theme information',
        () {
      //arrange
      themeService.isDarkModeOn = true;
      //Wenn Funktion ausgeführt wird, dann wird Test true
      when(mockThemeRepository.setThemeMode(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);
      //act
      themeService.setTheme(mode: t_mode);
      //assert
      expect(themeService.isDarkModeOn, t_mode);
      verify(mockThemeRepository.setThemeMode(mode: t_mode));
    });
  });
  group('toggleThemeMode', () {
    test('description', () {});
  });
  group('Init', () {
    test('description', () {});
  });
}
