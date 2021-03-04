import 'package:aulataller/application/boundaries/get_my_assists/get_my_assists.dart';
import 'package:aulataller/domain/entities/assist.dart';

import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/repositories/iServicesRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class GetMyAssists implements IGetMyAssists {
  IServicesRepository _servicesRepository;

  GetMyAssists({@required IServicesRepository serviceRepository})
      : _servicesRepository = serviceRepository;

  @override
  Future<Either<Failure, List<Assist>>> execute(Null input) async {
    final response = await _servicesRepository.getMyAssists();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
