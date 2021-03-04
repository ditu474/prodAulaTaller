import 'dart:async';

import 'package:aulataller/application/boundaries/reset_password/iReset_password.dart';
import 'package:aulataller/application/boundaries/send_recovery_token/iSend_recovery_token.dart';
import 'package:aulataller/presentation/models/models.dart';
import 'package:aulataller/presentation/models/newPassCode.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'forgot_pass_event.dart';
part 'forgot_pass_state.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  final ISendRecoveryToken _sendRecoveryToken;
  final IResetPassword _resetPassword;

  ForgotPassBloc({
    @required sendRecoveryToken,
    @required resetPassword,
  })  : assert(sendRecoveryToken != null, resetPassword != null),
        _sendRecoveryToken = sendRecoveryToken,
        _resetPassword = resetPassword;

  @override
  ForgotPassState get initialState => ForgotPassState();

  @override
  Stream<ForgotPassState> mapEventToState(
    ForgotPassEvent event,
  ) async* {
    if (event is ChangeForm) {
      yield ForgotPassState()
          .copyWith(alreadyHaveToken: !state.alreadyHaveToken);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is SendEmailButtonPressed) {
      yield* _mapSendEmailToState();
    } else if (event is TokenChanged) {
      yield* _mapTokenChangedToState(event.token);
    } else if (event is NewPasswordChanged) {
      yield* _mapNewPasswordChangedToState(event.newPassword);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(event.confirmPassword);
    } else if (event is ChangePasswordButtonPressed) {
      yield* _mapChangePasswordToState();
    }
  }

  Stream<ForgotPassState> _mapEmailChangedToState(String email) async* {
    final _email = Email.dirty(email);
    yield state.copyWith(
      email: _email,
      status: Formz.validate([_email]),
    );
  }

  Stream<ForgotPassState> _mapSendEmailToState() async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    final response = await _sendRecoveryToken.execute(state.email.value);
    if (response.isRight()) {
      yield state.copyWith(status: FormzStatus.submissionSuccess);
    } else {
      yield state.copyWith(
        status: FormzStatus.submissionFailure,
        error: response.fold((l) => l.message, (r) => null),
      );
    }
  }

  Stream<ForgotPassState> _mapTokenChangedToState(String token) async* {
    final _token = NewPassCode.dirty(token);
    yield state.copyWith(
      code: _token,
      status: Formz.validate([
        _token,
        state.confirmPassword,
        state.newPassword,
      ]),
    );
  }

  Stream<ForgotPassState> _mapNewPasswordChangedToState(
      String newPassword) async* {
    final _newPassword = Password.dirty(newPassword);
    final _confirmPassword = ConfirmPassword.dirty(
      value: state.confirmPassword.value,
      password: newPassword,
    );
    yield state.copyWith(
      newPassword: _newPassword,
      confirmPassword: _confirmPassword,
      status: Formz.validate([
        _newPassword,
        _confirmPassword,
        state.code,
      ]),
    );
  }

  Stream<ForgotPassState> _mapConfirmPasswordChangedToState(
      String confirmPassword) async* {
    final _confirmPassword = ConfirmPassword.dirty(
      value: confirmPassword,
      password: state.newPassword.value,
    );
    yield state.copyWith(
      confirmPassword: _confirmPassword,
      status: Formz.validate([
        state.newPassword,
        _confirmPassword,
        state.code,
      ]),
    );
  }

  Stream<ForgotPassState> _mapChangePasswordToState() async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    final input = ResetPasswordInput(
      newPassword: state.newPassword.value,
      resetToken: state.code.value,
    );
    final response = await _resetPassword.execute(input);
    if (response.isRight()) {
      yield state.copyWith(status: FormzStatus.submissionSuccess);
    } else {
      yield state.copyWith(
        status: FormzStatus.submissionFailure,
        error: response.fold((l) => l.message, (r) => null),
      );
    }
  }
}
