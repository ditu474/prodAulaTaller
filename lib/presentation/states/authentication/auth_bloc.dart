import 'dart:async';

import 'package:aulataller/application/boundaries/delete_user/iDeleteUser.dart';
import 'package:aulataller/application/boundaries/get_token/iGetLastUser.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IGetToken _getLastUser;
  final IDeleteUser _deleteLastUser;

  AuthBloc(
      {@required IGetToken getLastUser, @required IDeleteUser deleteLastUser})
      : _getLastUser = getLastUser,
        _deleteLastUser = deleteLastUser;

  @override
  AuthState get initialState => AuthenticationInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _getLastUser.execute('');
    if (isSignedIn.isRight()) {
      yield AuthenticationSuccess(isSignedIn.getOrElse(null));
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthState> _mapAuthenticationLoggedInToState() async* {
    final token = await _getLastUser.execute('');
    if (token.isRight()) {
      yield AuthenticationSuccess(token.getOrElse(null));
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthState> _mapAuthenticationLoggedOutToState() async* {
    await _deleteLastUser.execute('');
    yield AuthenticationFailure();
  }
}
