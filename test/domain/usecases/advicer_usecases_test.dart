import 'package:dartz/dartz.dart';
import 'package:firstcleanarchi/domain/enities/advice_entitiy.dart';
import 'package:firstcleanarchi/domain/failrues/failures.dart';
import 'package:firstcleanarchi/domain/repositories/advicer_repository.dart';
import 'package:firstcleanarchi/domain/usecases/advicer_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_usecases_test.mocks.dart';

@GenerateMocks([AdvicerRepository])
void main() {
  late AdvicerUsecases advicerUsecases;
  late MockAdvicerRepository mockAdvicerRepository;

  setUp(() {
    mockAdvicerRepository = MockAdvicerRepository();
    advicerUsecases = AdvicerUsecases(advicerRepository: mockAdvicerRepository);
  });

  final t_Advice = AdviceEntitiy(advice: 'test', id: 1);

  group('getAdviceUsecase', () {
    test('should return the same advice as repo', () async {
      // arrange: Test läuft wie er läuft
      when(mockAdvicerRepository.getAdviceFromApi())
          .thenAnswer((_) async => Right(t_Advice));
      // act: ich führe was aus
      final result = await advicerUsecases.getAdviceUseCase();
      // assert: Überprüfe die Ergebnisse
      expect(result, Right(t_Advice));
      verify(mockAdvicerRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });

    test('should return the same failure as repo', () async {
      // arrange: Test läuft wie er läuft
      when(mockAdvicerRepository.getAdviceFromApi())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act: ich führe was aus
      final result = await advicerUsecases.getAdviceUseCase();
      // assert: Überprüfe die Ergebnisse
      expect(result, Left(ServerFailure()));
      verify(mockAdvicerRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
  });
}
