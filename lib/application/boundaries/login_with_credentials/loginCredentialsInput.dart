import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;

class LoginCredentialsInput extends Equatable {
  final String email;
  final String password;

  LoginCredentialsInput({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
