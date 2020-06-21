import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

class Rol extends Equatable {
  final String _rol;

  Rol._(rol) : this._rol = rol;

  static Either<Failure, Rol> create(String value) {
    if (value != null)
      return Right(Rol._(value));
    else
      return Left(Failure('Rol can not be null'));
  }

  String get value => this._rol;

  @override
  String toString() {
    return 'Rol -> ${this._rol}';
  }

  @override
  List<Object> get props => [_rol];
}
