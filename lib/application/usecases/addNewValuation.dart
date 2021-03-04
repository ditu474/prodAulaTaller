import 'package:aulataller/application/boundaries/add_valuation.dart/iAddValuation.dart';
import 'package:aulataller/domain/repositories/iServicesRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:flutter/foundation.dart' show required;

class AddNewValuation extends IAddNewValuation {
  IServicesRepository _servicesRepository;

  AddNewValuation({@required IServicesRepository serviceRepository})
      : _servicesRepository = serviceRepository;

  @override
  Future<Either<Failure, Valuation>> execute(AddNewValuationInput input) async {
    final response = await _servicesRepository.addValuation(
      assistId: input.assistId,
      valuation: input.valuation,
      detail: input.detail,
    );
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
