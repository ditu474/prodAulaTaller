import 'package:aulataller/application/boundaries/add_assist/addAssist.dart';
import 'package:aulataller/domain/entities/assist.dart';

import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/repositories/iServicesRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class AddNewAssist implements IAddNewAssist {
  IServicesRepository _servicesRepository;

  AddNewAssist({@required IServicesRepository serviceRepository})
      : _servicesRepository = serviceRepository;

  @override
  Future<Either<Failure, Assist>> execute(String input) async {
    final response = await _servicesRepository.addAssist(input);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
