import 'package:aulataller/application/boundaries/get_token/iGetLastUser.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class GetToken extends IGetToken {
  final IAuthRepository _authRepository;

  GetToken({@required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, String>> execute(String input) async {
    final response = await _authRepository.getToken();

    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
