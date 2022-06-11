import 'package:dartz/dartz.dart';

import '../failrues/failures.dart';

abstract class ThemeRepository {
  Future<Either<Failure, bool>> getThemeMode();
  Future<void> setThemeMode({required bool mode});
}
