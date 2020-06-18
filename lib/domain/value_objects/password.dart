import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Password extends Equatable{
  final String _password;

  Password._(password):this._password = password;

  static Either<Failure,Password> create (String password){
    if(password!=null)
      return Right(Password._(password));
    else 
      return Left(Failure('Password can not be null'));
  }

  String get password => this._password;

  @override
  String toString() {
    return 'Password -> ${this._password}';
  }

  @override
  List<Object> get props => [_password];
}