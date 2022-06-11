import 'package:firstcleanarchi/application/advicer/advicer_bloc.dart';
import 'package:firstcleanarchi/application/advicer/theme/theme_service.dart';
import 'package:firstcleanarchi/domain/repositories/theme_repository.dart';
import 'package:firstcleanarchi/domain/usecases/advicer_usecases.dart';
import 'package:firstcleanarchi/infrastructur/datasources/advicer_remote_datasource.dart';
import 'package:firstcleanarchi/infrastructur/datasources/theme_local_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/repositories/advicer_repository.dart';
import 'infrastructur/repositories/advicer_repository_impl.dart';

import 'package:http/http.dart' as http;

import 'infrastructur/repositories/theme_repository_impl.dart';

final sl = GetIt.I; // sl ==> Service Locator

//Ganzen Zuweisungen registieren
Future<void> init() async {
  //! Application
  sl.registerFactory(() => AdvicerBloc(usecases: sl()));
  sl.registerLazySingleton(() => ThemeServiceImpl(themeRepository: sl()));
  //! UseCases
  sl.registerLazySingleton(() => AdvicerUsecases(advicerRepository: sl()));
  //! Repositories
  sl.registerLazySingleton<AdvicerRepository>(
      () => AdvicerRepositoryImpl(advicerRemoteDatasource: sl()));
  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(themeLocalDataSource: sl()));
  //! Datasources
  sl.registerLazySingleton<AdvicerRemoteDataSource>(
      () => AdvicerRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDatasourceImpl(sharedPreferences: sl()));
  //! extern
  //alles war wir nicht selbst geschrieben haben
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
