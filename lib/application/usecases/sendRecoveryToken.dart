import 'package:aulataller/application/boundaries/send_recovery_token/iSend_recovery_token.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class SendRecoveryToken extends ISendRecoveryToken {
  final IAuthRepository _authRepository;

  SendRecoveryToken({@required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> execute(String input) async {
    final response = await _authRepository.forgotPassword(email: input);
    return response.fold((err) => Left(err), (r) => Right(r));
  }
}
