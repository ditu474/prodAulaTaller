part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoginWithCredentialsButtonPressed extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

class FormSubmitted extends LoginEvent {}

class FacebookButtonPressed extends LoginEvent {}

class InstagramButtonPressed extends LoginEvent {}