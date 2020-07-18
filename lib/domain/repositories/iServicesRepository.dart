import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IServicesRepository {
  Future<Either<Failure, List<AulaAbiertaService>>> getAulaAbiertaServices();
  Future<Either<Failure, List<Service>>> getAllServices();
}
