import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/value_objects/email.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

abstract class IAuthRepository {
  Future<Either<Failure,User>> loginWithCredentials({@required Email email,@required Password password,});
  Future<Either<Failure,User>> findLastUser();
  Future<Either<Failure,User>> register({@required User newUser});
}