import 'package:aulataller/application/boundaries/get_current_user/iGetCurrentUser.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:flutter/foundation.dart' show required;

class GetCurrentUser implements IGetCurrentUser {
  final IAuthRepository _authRepository;

  GetCurrentUser({@required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> execute(String input) async {
    final response = await _authRepository.getCurrentUser();

    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
