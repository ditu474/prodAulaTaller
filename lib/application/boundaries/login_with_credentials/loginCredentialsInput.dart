import 'package:aulataller/domain/value_objects/email.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;

class LoginCredentialsInput extends Equatable{
  final Email email;
  final Password password;

  LoginCredentialsInput._({
     this.email,
     this.password
    });

  static Either<Failure,LoginCredentialsInput> createFromStrings({
    @required String email,
    @required String password
    }){
      if(email==null || password==null)
        return Left(Failure('Invalid Inputs'));
      else 
        return Right(LoginCredentialsInput._(
          email: Email.create(email).getOrElse(null),
          password: Password.create(password).getOrElse(null)
          )
        );
    }

  @override
  List<Object> get props => [email,password];
}