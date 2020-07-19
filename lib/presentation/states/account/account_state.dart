part of 'account_bloc.dart';

class AccountState extends Equatable {
  final User user;
  final bool loading;
  final bool showForm;
  final String error;
  final Password currentPassword;
  final Password newPassword;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;

  const AccountState({
    this.user,
    this.error = '',
    this.loading = false,
    this.showForm = false,
    this.currentPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzStatus.pure,
  });

  AccountState copyWith({
    User user,
    String error,
    bool loading,
    bool showForm,
    Password currentPassword,
    Password newPassword,
    ConfirmPassword confirmPassword,
    FormzStatus status,
  }) {
    return AccountState(
      user: user ?? this.user,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      showForm: showForm ?? this.showForm,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        user,
        error,
        loading,
        showForm,
        currentPassword,
        newPassword,
        confirmPassword,
        status
      ];

  @override
  bool get stringify => true;
}
