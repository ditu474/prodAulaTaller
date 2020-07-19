part of 'account_bloc.dart';

@immutable
abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetUserFromDatabase extends AccountEvent {}

class ChangePasswordButtonPressed extends AccountEvent {}

class ConfirmPasswordChange extends AccountEvent {}

class CurrentPasswordChanged extends AccountEvent {
  final String currentPassword;

  const CurrentPasswordChanged({@required this.currentPassword});

  @override
  List<Object> get props => [currentPassword];
}

class NewPasswordChanged extends AccountEvent {
  final String newPassword;

  const NewPasswordChanged({@required this.newPassword});

  @override
  List<Object> get props => [newPassword];
}

class PasswordConfirmChanged extends AccountEvent {
  final String passwordConfirm;

  const PasswordConfirmChanged({@required this.passwordConfirm});

  @override
  List<Object> get props => [passwordConfirm];
}
