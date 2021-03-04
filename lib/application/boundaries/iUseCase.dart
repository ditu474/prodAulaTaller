import 'package:aulataller/domain/entities/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IUseCase<TUseCaseInput, TUseCaseOutput> {
  Future<Either<Failure, TUseCaseOutput>> execute(TUseCaseInput input);
}
