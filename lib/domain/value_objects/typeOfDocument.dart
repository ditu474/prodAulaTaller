import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class TypeOfDocument extends Equatable{
  final String _typeOfDocument;

  TypeOfDocument._(typeOfDocument): this._typeOfDocument=typeOfDocument;

  static Either<Failure,TypeOfDocument> create (String value){
    if(value!=null)
      return Right(TypeOfDocument._(value));
    else
      return Left(Failure('TypeOfDocument can not be null'));
  }

  String get typeOfDocument => this._typeOfDocument;

  @override
  String toString() {
    return 'TypeOfDocument -> ${this._typeOfDocument}';
  }

  @override
  List<Object> get props => [_typeOfDocument];
}