import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class Document extends Equatable{
  final dynamic _document;

  Document._(document): this._document=document;

  static Either<Failure,Document> create (dynamic value){
    if(value!=null)
      return Right(Document._(value));
    else
      return Left(Failure('Document can not be null'));
  }

  dynamic get document => this._document;

  @override
  String toString() {
    return 'Document -> ${this._document}';
  }

  @override
  List<Object> get props => [_document];
}