import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:aulataller/infrastructure/datasources/iLocalDataSource.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/utils/networkInfo.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:aulataller/domain/value_objects/email.dart';
import 'package:flutter/foundation.dart' show required;

class AuthRepository implements IAuthRepository {
  IRemoteDataSource remoteDataSource;
  INetworkInfo networkInfo;
  ILocalDataSource localDataSource;

  AuthRepository(
      {@required this.remoteDataSource,
      @required this.networkInfo,
      @required this.localDataSource});

  @override
  Future<Either<Failure, String>> findLastUser() async {
    try {
      final response = await localDataSource.getToken();
      if (response != null)
        return Right(response);
      else
        return Left(Failure('No se encontró usuario'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithCredentials(
      {Email email, Password password}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.loginWithCredentials(
            email: email, password: password);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({Email email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> resetPassword(
      {Password password, String resetToken}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> register({User newUser}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.register(newUser: newUser);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, bool>> saveLastUser({User user}) async {
    try {
      final response = await localDataSource.setToken(token: user.token.value);
      if (response)
        return Right(true);
      else
        return Left(Failure('No se logró guardar el usuario'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> userLogout() async {
    try {
      final response = await localDataSource.deleteToken();
      if (response)
        return Right(true);
      else
        return Left(Failure('No se logró borrar el token'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
