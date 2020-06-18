import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Email extends Equatable{
  final String _email;

  Email._(email): this._email=email;

  static Either<Failure,Email> create (String value){
    if(value!=null)
      return Right(Email._(value));
    else
      return Left(Failure('Email can not be null'));
  }

  String get email => this._email;

  @override
  String toString() {
    return 'Email -> ${this._email}';
  }

  @override
  List<Object> get props => [_email];
  }