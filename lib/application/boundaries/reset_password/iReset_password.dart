import 'package:aulataller/application/boundaries/iUseCase.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;

abstract class IResetPassword extends IUseCase<ResetPasswordInput, User> {}

class ResetPasswordInput extends Equatable {
  final String resetToken;
  final String newPassword;

  const ResetPasswordInput(
      {@required this.resetToken, @required this.newPassword});

  @override
  List<Object> get props => [
        resetToken,
        newPassword,
      ];
}
