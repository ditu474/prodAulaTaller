part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthEvent {}

class AuthenticationLoggedIn extends AuthEvent {}

class AuthenticationLoggedOut extends AuthEvent {}