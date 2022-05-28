import 'package:firstcleanarchi/domain/failrues/failures.dart';
import 'package:firstcleanarchi/domain/repositories/advicer_repository.dart';

import '../enities/advice_entitiy.dart';
import 'package:dartz/dartz.dart';

class AdvicerUsecases {
  final AdvicerRepository advicerRepository;
  AdvicerUsecases({required this.advicerRepository});

  Future<Either<Failure, AdviceEntitiy>> getAdviceUseCase() async {
    return advicerRepository.getAdviceFromApi();
  }
}
