import 'package:firstcleanarchi/application/advicer/advicer_bloc.dart';
import 'package:firstcleanarchi/domain/usecases/advicer_usecases.dart';
import 'package:firstcleanarchi/infrastructur/datasources/advicer_remote_datasource.dart';
import 'package:get_it/get_it.dart';

import 'domain/repositories/advicer_repository.dart';
import 'infrastructur/repositories/advicer_repository_impl.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.I; // sl ==> Service Locator

//Ganzen Zuweisungen registieren
Future<void> init() async {
  //! Blocs
  sl.registerFactory(() => AdvicerBloc(usecases: sl()));
  //! UseCases
  sl.registerLazySingleton(() => AdvicerUsecases(advicerRepository: sl()));
  //! Repositories
  sl.registerLazySingleton<AdvicerRepository>(
      () => AdvicerRepositoryImpl(advicerRemoteDatasource: sl()));
  //! Datasources
  sl.registerLazySingleton<AdvicerRemoteDataSource>(
      () => AdvicerRemoteDatasourceImpl(client: sl()));
  //! extern
  //alles war wir nicht selbst geschrieben haben
  sl.registerLazySingleton(() => http.Client());
}
