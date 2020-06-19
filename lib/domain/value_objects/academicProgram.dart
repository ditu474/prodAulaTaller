import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class AcademicProgram extends Equatable{
  final String _academicProgram;

  AcademicProgram._(academicProgram): this._academicProgram=academicProgram;

  static Either<Failure,AcademicProgram> create (String value){
    if(value!=null)
      return Right(AcademicProgram._(value));
    else
      return Left(Failure('AcademicProgram can not be null'));
  }

  String get academicProgram => this._academicProgram;

  @override
  String toString() {
    return 'AcademicProgram -> ${this._academicProgram}';
  }

  @override
  List<Object> get props => [_academicProgram];
}