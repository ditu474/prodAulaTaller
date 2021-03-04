import 'package:aulataller/domain/entities/assist.dart';
import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:aulataller/domain/repositories/iServicesRepository.dart';
import 'package:aulataller/infrastructure/datasources/iLocalDataSource.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/utils/networkInfo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class ServiceRepository implements IServicesRepository {
  IRemoteDataSource remoteDataSource;
  INetworkInfo networkInfo;
  ILocalDataSource localDataSource;

  ServiceRepository({
    @required this.remoteDataSource,
    @required this.networkInfo,
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<AulaAbiertaService>>>
      getAulaAbiertaServices() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getToken();
        if (token == null)
          return Left(Failure('No se encontró un usuario logueado'));
        final response = await remoteDataSource.getAulaAbiertaServices(token);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getAllServices() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getToken();
        if (token == null)
          return Left(Failure('No se encontró un usuario logueado'));
        final response = await remoteDataSource.getAllServices(token);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, List<Valuation>>> getMyValuations() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getToken();
        if (token == null)
          return Left(Failure('No se encontró un usuario logueado'));
        final response = await remoteDataSource.getMyValuations(token);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, List<Assist>>> getMyAssists() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getToken();
        if (token == null)
          return Left(Failure('No se encontró un usuario logueado'));
        final response = await remoteDataSource.getMyAssists(token);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, Assist>> addAssist(String code) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getToken();
        if (token == null)
          return Left(Failure('No se encontró un usuario logueado'));
        final response =
            await remoteDataSource.addNewAssist(code: code, token: token);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, Valuation>> addValuation(
      {String assistId, int valuation, String detail}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getToken();
        if (token == null)
          return Left(Failure('No se encontró un usuario logueado'));
        final response = await remoteDataSource.addValuation(
            assistId: assistId,
            valuation: valuation,
            detail: detail,
            token: token);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    } else {
      return Left(Failure('No tienes conexión a internet'));
    }
  }
}
