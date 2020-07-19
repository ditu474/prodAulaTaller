import 'package:aulataller/application/boundaries/get_my_valuations/iGetMyValuations.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/repositories/iServicesRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class GetMyValuations implements IGetMyValuations {
  IServicesRepository _servicesRepository;

  GetMyValuations({@required IServicesRepository serviceRepository})
      : _servicesRepository = serviceRepository;

  @override
  Future<Either<Failure, List<Valuation>>> execute(Null input) async {
    final response = await _servicesRepository.getMyValuations();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
