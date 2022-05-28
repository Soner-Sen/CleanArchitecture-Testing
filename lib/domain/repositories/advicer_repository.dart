import 'package:dartz/dartz.dart';
import 'package:firstcleanarchi/domain/enities/advice_entitiy.dart';
import 'package:firstcleanarchi/domain/failrues/failures.dart';

abstract class AdvicerRepository {
  Future<Either<Failure, AdviceEntitiy>> getAdviceFromApi();
}
