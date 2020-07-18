import 'package:aulataller/application/boundaries/get_all_services/iGetAllServices.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/domain/repositories/iServicesRepository.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:dartz/dartz.dart';

class GetAllServices implements IGetAllServices {
  IServicesRepository _servicesRepository;

  GetAllServices({@required IServicesRepository serviceRepository})
      : _servicesRepository = serviceRepository;

  @override
  Future<Either<Failure, List<Service>>> execute(Null input) async {
    final response = await _servicesRepository.getAllServices();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
