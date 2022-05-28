import 'package:firstcleanarchi/domain/failrues/failures.dart';
import 'package:firstcleanarchi/domain/enities/advice_entitiy.dart';
import 'package:dartz/dartz.dart';
import 'package:firstcleanarchi/domain/repositories/advicer_repository.dart';

import '../datasources/advicer_remote_datasource.dart';

class AdvicerRepositoryImpl implements AdvicerRepository {
  final AdvicerRemoteDataSource advicerRemoteDatasource;
  AdvicerRepositoryImpl({required this.advicerRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntitiy>> getAdviceFromApi() async {
    try {
      final remoteAdvice =
          await advicerRemoteDatasource.getRandomAdviceFromApi();
      return Right(remoteAdvice);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
