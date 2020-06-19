import 'package:aulataller/application/boundaries/save_user/iSaveUser.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:flutter/foundation.dart' show required;

class SaveUserUseCase extends ISaveUser{
  final IAuthRepository _authRepository;

  SaveUserUseCase({
    @required IAuthRepository authRepository
    }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> execute(User input) async {
    final response = await _authRepository.saveLastUser(user: input);
    return response.fold((err)=>Left(err),(r)=>Right(r));
  }
}