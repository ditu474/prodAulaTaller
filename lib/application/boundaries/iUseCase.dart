import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IUseCase<TUseCaseInput,TUseCaseOutput>{
  Future<Either<Failure,TUseCaseOutput>> execute(TUseCaseInput input);
}