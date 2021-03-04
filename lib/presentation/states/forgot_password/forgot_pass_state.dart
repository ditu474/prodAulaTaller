part of 'forgot_pass_bloc.dart';

class ForgotPassState extends Equatable {
  final bool alreadyHaveToken;
  final Email email;
  final NewPassCode code;
  final Password newPassword;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;
  final String error;

  const ForgotPassState({
    this.alreadyHaveToken = false,
    this.email = const Email.pure(),
    this.code = const NewPassCode.pure(),
    this.newPassword = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzStatus.pure,
    this.error = "",
  });

  ForgotPassState copyWith({
    bool alreadyHaveToken,
    Email email,
    NewPassCode code,
    Password newPassword,
    ConfirmPassword confirmPassword,
    FormzStatus status,
    String error,
  }) {
    return ForgotPassState(
      alreadyHaveToken: alreadyHaveToken ?? this.alreadyHaveToken,
      email: email ?? this.email,
      code: code ?? this.code,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        alreadyHaveToken,
        email,
        code,
        newPassword,
        confirmPassword,
        status,
        error,
      ];

  @override
  bool get stringify => true;
}
