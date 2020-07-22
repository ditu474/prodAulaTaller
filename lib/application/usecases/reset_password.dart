import 'package:aulataller/application/boundaries/reset_password/iReset_password.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class ResetPassword extends IResetPassword {
  final IAuthRepository _authRepository;

  ResetPassword({@required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> execute(ResetPasswordInput input) async {
    final response = await _authRepository.resetPassword(
        password: input.newPassword, resetToken: input.resetToken);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
