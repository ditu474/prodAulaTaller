import 'package:aulataller/application/boundaries/login_with_credentials/iLoginWithCredentials.dart';
import 'package:aulataller/application/boundaries/login_with_credentials/loginCredentialsInput.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:flutter/foundation.dart' show required;

class LoginWithCredentialsUseCase extends ILoginWithCredentials{
  final IAuthRepository _authRepository;

  LoginWithCredentialsUseCase({
    @required IAuthRepository authRepository
    }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> execute(LoginCredentialsInput input) async{
    final user = await _authRepository.loginWithCredentials(email: input.email, password: input.password);

    return user.fold((err) => Left(err), (user) => Right(user));
  }
}