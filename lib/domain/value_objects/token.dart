import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String _token;

  Token._(token) : this._token = token;

  static Either<Failure, Token> create(String value) {
    if (value != null)
      return Right(Token._(value));
    else
      return Left(Failure('Token can not be null'));
  }

  String get value => this._token;

  @override
  String toString() {
    return 'Token -> ${this._token}';
  }

  @override
  List<Object> get props => [_token];
}
