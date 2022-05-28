import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firstcleanarchi/domain/failrues/failures.dart';
import 'package:firstcleanarchi/domain/usecases/advicer_usecases.dart';
import 'package:meta/meta.dart';

import '../../domain/enities/advice_entitiy.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const GENERAL_FAILURE_MESSAGE = 'Cache Failure';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdvicerUsecases usecases;
  AdvicerBloc({required this.usecases}) : super(AdvicerInitial()) {
    on<AdvicerEvent>((event, emit) async {
      emit(AdvicerLoading());
      //Do something
      final adviceOrFailure = await usecases.getAdviceUseCase();
      emit(
        adviceOrFailure.fold(
          (failure) => AdvicerError(error: _mapFailureToMessage(failure)),
          (advice) => AdvicerLoaded(advice: advice.advice),
        ),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case GeneralFailure:
        return GENERAL_FAILURE_MESSAGE;
      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }
}
