import 'package:aulataller/application/boundaries/get_aula_abierta_services.dart/iGetAulaAbiertaServices.dart';
import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/repositories/iServicesRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class GetAulaAbiertaServices implements IGetAulaAbiertaServices {
  IServicesRepository _servicesRepository;

  GetAulaAbiertaServices({@required IServicesRepository serviceRepository})
      : _servicesRepository = serviceRepository;

  @override
  Future<Either<Failure, List<AulaAbiertaService>>> execute(Null _) async {
    final services = await _servicesRepository.getAulaAbiertaServices();

    return services.fold(
      (err) => Left(err),
      (services) => Right(services),
    );
  }
}
