import 'package:aulataller/domain/entities/assist.dart';
import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:dartz/dartz.dart';

abstract class IServicesRepository {
  Future<Either<Failure, List<AulaAbiertaService>>> getAulaAbiertaServices();
  Future<Either<Failure, List<Service>>> getAllServices();
  Future<Either<Failure, List<Valuation>>> getMyValuations();
  Future<Either<Failure, List<Assist>>> getMyAssists();
  Future<Either<Failure, Assist>> addAssist(String code);
}
