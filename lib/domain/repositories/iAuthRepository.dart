import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

abstract class IAuthRepository {
  Future<Either<Failure, User>> loginWithCredentials({
    @required String email,
    @required String password,
  });
  Future<Either<Failure, bool>> saveLastUser({@required User user});
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, String>> updatePassword(
      {@required String newPassword, @required String currentPassword});
  Future<Either<Failure, bool>> userLogout();
  Future<Either<Failure, bool>> forgotPassword({@required String email});
  Future<Either<Failure, User>> resetPassword(
      {@required String password, @required String resetToken});
  Future<Either<Failure, User>> register({@required User newUser});
}
