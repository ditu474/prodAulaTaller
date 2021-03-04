part of 'forgot_pass_bloc.dart';

@immutable
abstract class ForgotPassEvent extends Equatable {
  const ForgotPassEvent();

  @override
  List<Object> get props => [];
}

class ChangeForm extends ForgotPassEvent {}

class EmailChanged extends ForgotPassEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SendEmailButtonPressed extends ForgotPassEvent {}

class TokenChanged extends ForgotPassEvent {
  final String token;

  const TokenChanged(this.token);

  @override
  List<Object> get props => [token];
}

class NewPasswordChanged extends ForgotPassEvent {
  final String newPassword;

  const NewPasswordChanged(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

class ConfirmPasswordChanged extends ForgotPassEvent {
  final String confirmPassword;

  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class ChangePasswordButtonPressed extends ForgotPassEvent {}
