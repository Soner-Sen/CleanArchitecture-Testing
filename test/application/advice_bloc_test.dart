import 'package:dartz/dartz.dart';
import 'package:firstcleanarchi/application/advicer/advicer_bloc.dart';
import 'package:firstcleanarchi/domain/enities/advice_entitiy.dart';
import 'package:firstcleanarchi/domain/failrues/failures.dart';
import 'package:firstcleanarchi/domain/usecases/advicer_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_bloc_test.mocks.dart';

@GenerateMocks([AdvicerUsecases])
void main() {
  late AdvicerBloc advicerBloc;
  late MockAdvicerUsecases mockAdvicerUsecases;

  //Depenencies zuweisen
  setUp(() {
    mockAdvicerUsecases = MockAdvicerUsecases();
    advicerBloc = AdvicerBloc(usecases: mockAdvicerUsecases);
  });

  //Schauen ob InitalState korrekt gesetzt ist
  test('initState should be AdvicerInit', () {
    //Assert: Prüfe
    expect(advicerBloc.state, equals(AdvicerInitial()));
  });

  //Welche Events haben wir?
  group('AdviceRequestedEvent', () {
    final t_Advice = AdviceEntitiy(advice: "test", id: 1);
    final t_Advice_str = "test";

    test('should call usecase if event is added', () async {
      //Arrange
      when(mockAdvicerUsecases.getAdviceUseCase())
          .thenAnswer((_) async => Right(t_Advice));

      //Act
      advicerBloc.add(AdviceRequestedEvent());
      //Warten bis usecases ausgeführt wurde
      await untilCalled(mockAdvicerUsecases.getAdviceUseCase());

      //Assert
      verify(mockAdvicerUsecases.getAdviceUseCase());
      verifyNoMoreInteractions(mockAdvicerUsecases);
    });

    test('should emit loading then the loaded state after event is added',
        () async {
      //Arrange
      when(mockAdvicerUsecases.getAdviceUseCase())
          .thenAnswer((_) async => Right(t_Advice));

      //Assert later
      final expected = [
        AdvicerLoading(),
        AdvicerLoaded(advice: t_Advice_str),
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expected));

      //Act
      advicerBloc.add(AdviceRequestedEvent());
    });

    test(
        'should emit loading then the error state after event is added -> Server Failure',
        () async {
      //Arrange
      when(mockAdvicerUsecases.getAdviceUseCase())
          .thenAnswer((_) async => Left(ServerFailure()));

      //Assert later
      final expected = [
        AdvicerLoading(),
        AdvicerError(error: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expected));

      //Act
      advicerBloc.add(AdviceRequestedEvent());
    });

    test(
        'should emit loading then the error state after event is added -> General Failure',
        () async {
      //Arrange
      when(mockAdvicerUsecases.getAdviceUseCase())
          .thenAnswer((_) async => Left(GeneralFailure()));

      //Assert later
      final expected = [
        AdvicerLoading(),
        AdvicerError(error: GENERAL_FAILURE_MESSAGE)
      ];
      expectLater(advicerBloc.stream, emitsInOrder(expected));

      //Act
      advicerBloc.add(AdviceRequestedEvent());
    });
  });
}
