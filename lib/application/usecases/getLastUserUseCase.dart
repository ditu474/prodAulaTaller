import 'package:aulataller/application/boundaries/get_last_user/iGetLastUser.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:flutter/foundation.dart' show required;

class GetLastUserUseCase extends IGetLastUser{
  final IAuthRepository _authRepository;

  GetLastUserUseCase({
    @required IAuthRepository authRepository
    }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, String>> execute(Null input) async {
    final response = await _authRepository.findLastUser();

    return response.fold((l) => Left(l), (r) => Right(r));
  }
}