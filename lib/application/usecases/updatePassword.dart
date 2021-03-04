import 'package:aulataller/application/boundaries/update_password/iUpdatePassword.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class UpdatePassword implements IUpdatePassword {
  IAuthRepository _authRepository;

  UpdatePassword({@required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, String>> execute(UpdatePasswordInput input) async {
    final response = await _authRepository.updatePassword(
      currentPassword: input.currentPassword,
      newPassword: input.newPassword,
    );
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
