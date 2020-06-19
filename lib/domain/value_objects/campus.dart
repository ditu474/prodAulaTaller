import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class Campus extends Equatable{
  final String _campus;

  Campus._(campus): this._campus=campus;

  static Either<Failure,Campus> create (String value){
    if(value!=null)
      return Right(Campus._(value));
    else
      return Left(Failure('Campus can not be null'));
  }

  String get campus => this._campus;

  @override
  String toString() {
    return 'Campus -> ${this._campus}';
  }

  @override
  List<Object> get props => [_campus];
}