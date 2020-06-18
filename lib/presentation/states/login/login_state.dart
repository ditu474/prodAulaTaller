part of 'login_bloc.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String error;
  final bool linkError;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.error = '',
    this.linkError = false
  });

  LoginState copyWith({
    Email email,
    Password password,
    FormzStatus status,
    String error,
    bool linkError
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
      linkError: linkError ?? this.linkError,
    );
  }

  @override
  List<Object> get props => [email, password, status, error, linkError];

  @override
  bool get stringify => true;
}