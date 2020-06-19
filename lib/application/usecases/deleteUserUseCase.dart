import 'package:aulataller/application/boundaries/delete_user/iDeleteUser.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:flutter/foundation.dart' show required;

class DeleteUserUseCase implements IDeleteUser{
  final IAuthRepository _authRepository;

  DeleteUserUseCase({
    @required IAuthRepository authRepository
    }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> execute(String input) async {
    final response = await _authRepository.userLogout();
    return response.fold((err)=>Left(err),(r)=>Right(r));
  }
}