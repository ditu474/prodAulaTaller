import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class Name extends Equatable{
  final String _name;

  Name._(name): this._name=name;

  static Either<Failure,Name> create (String value){
    if(value!=null)
      return Right(Name._(value));
    else
      return Left(Failure('Name can not be null'));
  }

  String get name => this._name;

  @override
  String toString() {
    return 'Name -> ${this._name}';
  }

  @override
  List<Object> get props => [_name];
  }