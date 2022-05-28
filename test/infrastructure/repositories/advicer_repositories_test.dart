//Main: Programmeinstieg für jeden Test
import 'package:dartz/dartz.dart';
import 'package:firstcleanarchi/domain/enities/advice_entitiy.dart';
import 'package:firstcleanarchi/domain/failrues/failures.dart';
import 'package:firstcleanarchi/domain/repositories/advicer_repository.dart';
import 'package:firstcleanarchi/infrastructur/datasources/advicer_remote_datasource.dart';
import 'package:firstcleanarchi/infrastructur/models/advice_model.dart';
import 'package:firstcleanarchi/infrastructur/repositories/advicer_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_repositories_test.mocks.dart';

@GenerateMocks([AdvicerRemoteDataSource])
void main() {
  //Was wir testen wollen
  late AdvicerRepository advicerRepository;
  //Haben eine Abhängigkeit => Mocken
  late MockAdvicerRemoteDataSource mockAdvicerRemoteDataSource;

  setUp(() {
    //Bekommt MockAdvicerRemoteDatasource zugewiesen
    mockAdvicerRemoteDataSource = MockAdvicerRemoteDataSource();
    advicerRepository = AdvicerRepositoryImpl(
        advicerRemoteDatasource: mockAdvicerRemoteDataSource);
  });

  //Description: Welche Funktion wollen wir testen?
  group("getAdviceFromApi", () {
    final t_AdviceModel = AdviceModel(advice: 'test', id: 1);
    final AdviceEntitiy t_AdviceEntitiy = t_AdviceModel;

    test(
        'Should return remote data if the call to remote datasource is successfull',
        () async {
      //Arrange Szenario
      when(mockAdvicerRemoteDataSource.getRandomAdviceFromApi())
          .thenAnswer((_) async => t_AdviceModel);

      //Act (testen)

      final result = await advicerRepository.getAdviceFromApi();

      //Assert (Vergleichen)
      verify(mockAdvicerRemoteDataSource.getRandomAdviceFromApi());
      expect(result, Right(t_AdviceEntitiy));
      verifyNoMoreInteractions(mockAdvicerRemoteDataSource);
    });

    test('Should return server failrue if datasource throws server-excepiton',
        () async {
      //Arrange Szenario

      when(mockAdvicerRemoteDataSource.getRandomAdviceFromApi())
          .thenThrow(ServerFailure());

      //Act (testen)
      final result = await advicerRepository.getAdviceFromApi();

      //Assert (Vergleichen)
      verify(mockAdvicerRemoteDataSource.getRandomAdviceFromApi());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockAdvicerRemoteDataSource);
    });
  });
}
