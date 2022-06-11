import 'package:flutter/widgets.dart';

import '../../../domain/repositories/theme_repository.dart';

abstract class ThemeService extends ChangeNotifier {
  late bool isDarkModeOn;

  Future<void> toggleTheme();

  Future<void> setTheme({required bool mode});

  Future<void> init();
}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService {
  //Dependency? Benutzt die Funktionen aus dem Repository
  final ThemeRepository themeRepository;
  ThemeServiceImpl({required this.themeRepository});

  @override
  bool isDarkModeOn = true;

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> setTheme({required bool mode}) async {
    isDarkModeOn = mode;
    notifyListeners();
    await themeRepository.setThemeMode(mode: isDarkModeOn);
  }

  @override
  Future<void> toggleTheme() {
    // TODO: implement toggleTheme
    throw UnimplementedError();
  }
}
