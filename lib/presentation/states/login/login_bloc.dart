import 'dart:async';

import 'package:aulataller/application/boundaries/login_with_credentials/iLoginWithCredentials.dart';
import 'package:aulataller/application/boundaries/login_with_credentials/loginCredentialsInput.dart';
import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:aulataller/application/boundaries/save_user/iSaveUser.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;
import '../../models/models.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ILoginWithCredentials _loginWithCredentials;
  IOpenDynamicLink _openDynamicLink;
  ISaveUser _saveUser;

  LoginBloc(
      {@required loginWithCredentials,
      @required openDynamicLink,
      @required saveUser})
      : assert(loginWithCredentials != null, openDynamicLink != null),
        _loginWithCredentials = loginWithCredentials,
        _openDynamicLink = openDynamicLink,
        _saveUser = saveUser;

  @override
  LoginState get initialState => const LoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedState(eventEmail: event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedState(eventPassword: event.password);
    } else if (event is LoginWithCredentialsButtonPressed) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        yield* _mapLoginWithCredentialsState(
            email: state.email.value, password: state.password.value);
      }
    } else if (event is FacebookButtonPressed) {
      yield* _mapFacebookButtonPressedState();
    } else if (event is InstagramButtonPressed) {
      yield* _mapInstagramButtonPressedState();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsState({
    String email,
    String password,
  }) async* {
    var credentials = LoginCredentialsInput(email: email, password: password);
    var response = await _loginWithCredentials.execute(credentials);
    if (response.isRight()) {
      await _saveUser.execute(response.getOrElse(null));
      yield state.copyWith(status: FormzStatus.submissionSuccess);
    } else {
      yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: response.fold((l) => l.message, (r) => null));
    }
  }

  Stream<LoginState> _mapEmailChangedState({String eventEmail}) async* {
    final email = Email.dirty(eventEmail);
    yield state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    );
  }

  Stream<LoginState> _mapPasswordChangedState({String eventPassword}) async* {
    final password = Password.dirty(eventPassword);
    yield state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    );
  }

  Stream<LoginState> _mapFacebookButtonPressedState() async* {
    final response = await _openDynamicLink
        .execute("https://www.facebook.com/aulatallerpcjic/");
    if (response.isLeft()) {
      yield state.copyWith(
          error: "No se logró abrir facebook", linkError: true);
    } else {
      yield state.copyWith(linkError: false);
    }
  }

  Stream<LoginState> _mapInstagramButtonPressedState() async* {
    final response = await _openDynamicLink
        .execute("https://www.instagram.com/aulatallerpoli/");
    if (response.isLeft()) {
      yield state.copyWith(
          error: "No se logró abrir instagram", linkError: true);
    } else {
      yield state.copyWith(linkError: false);
    }
  }
}
