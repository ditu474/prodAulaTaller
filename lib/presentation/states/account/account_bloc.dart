import 'dart:async';

import 'package:aulataller/application/boundaries/get_current_user/iGetCurrentUser.dart';
import 'package:aulataller/application/boundaries/update_password/iUpdatePassword.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/presentation/models/confirmPassword.dart';
import 'package:aulataller/presentation/models/password.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  IGetCurrentUser _getCurrentUser;
  IUpdatePassword _updatePassword;

  AccountBloc({@required getCurrentUser, @required updatePassword})
      : assert(
          getCurrentUser != null,
          updatePassword != null,
        ),
        _getCurrentUser = getCurrentUser,
        _updatePassword = updatePassword;

  @override
  AccountState get initialState => AccountState();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is GetUserFromDatabase) {
      yield state.copyWith(loading: true);
      yield* _mapGetUserState();
    } else if (event is ConfirmPasswordChange) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      yield* _mapChangePasswordState();
    } else if (event is CurrentPasswordChanged) {
      yield* _mapCurrentPasswordState(event.currentPassword);
    } else if (event is NewPasswordChanged) {
      yield* _mapNewPasswordState(event.newPassword);
    } else if (event is PasswordConfirmChanged) {
      yield* _mapPasswordConfirmState(event.passwordConfirm);
    }
  }

  Stream<AccountState> _mapGetUserState() async* {
    final response = await _getCurrentUser.execute(null);
    if (response.isLeft()) {
      yield state.copyWith(
        error: response.fold((l) => l.message, (r) => null),
        loading: false,
      );
    } else if (response.isRight()) {
      yield state.copyWith(
        user: response.getOrElse(null),
        loading: false,
        error: '',
      );
    }
  }

  Stream<AccountState> _mapChangePasswordState() async* {
    UpdatePasswordInput input = UpdatePasswordInput(
      currentPassword: state.currentPassword.value,
      newPassword: state.newPassword.value,
    );
    final response = await _updatePassword.execute(input);
    if (response.isLeft()) {
      yield state.copyWith(
        error: response.fold((l) => l.message, (r) => null),
        status: FormzStatus.submissionFailure,
      );
    } else if (response.isRight()) {
      yield state.copyWith(status: FormzStatus.submissionSuccess);
    }
  }

  Stream<AccountState> _mapCurrentPasswordState(String currentPassword) async* {
    final _currentPassword = Password.dirty(currentPassword);
    yield state.copyWith(
      currentPassword: _currentPassword,
      status: Formz.validate([
        _currentPassword,
        state.newPassword,
        state.confirmPassword,
      ]),
    );
  }

  Stream<AccountState> _mapNewPasswordState(String newPassword) async* {
    final _newPassword = Password.dirty(newPassword);
    final confirmPassword = ConfirmPassword.dirty(
      value: state.confirmPassword.value,
      password: newPassword,
    );
    yield state.copyWith(
      newPassword: _newPassword,
      confirmPassword: confirmPassword,
      status: Formz.validate([
        state.currentPassword,
        _newPassword,
        confirmPassword,
      ]),
    );
  }

  Stream<AccountState> _mapPasswordConfirmState(String confirmPassword) async* {
    final _confirmPassword = ConfirmPassword.dirty(
      value: confirmPassword,
      password: state.newPassword.value,
    );
    yield state.copyWith(
      confirmPassword: _confirmPassword,
      status: Formz.validate([
        state.currentPassword,
        state.newPassword,
        _confirmPassword,
      ]),
    );
  }
}
