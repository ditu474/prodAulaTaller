import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class Semester extends Equatable {
  final int _semester;

  Semester._(semester) : this._semester = semester;

  static Either<Failure, Semester> create(int value) {
    if (value != null)
      return Right(Semester._(value));
    else
      return Left(Failure('Semester can not be null'));
  }

  dynamic get value => this._semester;

  @override
  String toString() {
    return 'Semester -> ${this._semester}';
  }

  @override
  List<Object> get props => [_semester];
}
