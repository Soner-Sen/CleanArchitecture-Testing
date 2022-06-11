import 'package:firstcleanarchi/domain/failrues/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firstcleanarchi/domain/repositories/theme_repository.dart';
import 'package:firstcleanarchi/infrastructur/datasources/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource themeLocalDataSource;
  ThemeRepositoryImpl({required this.themeLocalDataSource});

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    try {
      final themeMode = await themeLocalDataSource.getLastTheme();
      return Right(themeMode);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> setThemeMode({required bool mode}) {
    return themeLocalDataSource.cacheTheme(mode: mode);
  }
}
