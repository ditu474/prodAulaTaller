import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:aulataller/infrastructure/datasources/iLocalDataSource.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/utils/networkInfo.dart';
import 'package:dartz/dartz.dart';
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
  Future<Either<Failure, User>> loginWithCredentials(
      {String email, String password}) async {
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
  Future<Either<Failure, String>> forgotPassword({String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> resetPassword(
      {String password, String resetToken}) {
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
      final response = await localDataSource.setToken(token: user.token);
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

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getToken();
        if (token == null)
          return Left(Failure('No se encontró un usuario logueado'));
        final response = await remoteDataSource.getUser(token);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
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
  Future<Either<Failure, String>> updatePassword(
      {String newPassword, String currentPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getToken();
        if (token == null)
          return Left(Failure('No se encontró un usuario logueado'));
        final response = await remoteDataSource.updatePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
          token: token,
        );
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }
}
