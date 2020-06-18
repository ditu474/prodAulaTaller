import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:aulataller/infrastructure/datasources/remoteDataSource.dart';
import 'package:aulataller/utils/networkInfo.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:aulataller/domain/value_objects/email.dart';
import 'package:flutter/foundation.dart' show required;

class AuthRepository implements IAuthRepository{
  RemoteDataSource remoteDataSource;
  INetworkInfo networkInfo;  

  AuthRepository({@required this.remoteDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, User>> findLastUser() {
    // TODO: implement findLastUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> loginWithCredentials({Email email, Password password}) async{
    if(await networkInfo.isConnected){
      try{
        final response = await remoteDataSource.loginWithCredentials(email: email,password: password);
        return Right(response);
      }on Exception{
        return Left(Failure('Correo y contraseña invalidos'));
      }
    }else{
      return Left(Failure('No tienes conexion a internet'));
    }
  }

  @override
  Future<Either<Failure, User>> register({User newUser}) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
  
}