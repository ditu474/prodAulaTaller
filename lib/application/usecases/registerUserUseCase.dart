import 'package:aulataller/application/boundaries/register_user/iRegisterUser.dart';
import 'package:aulataller/domain/entities/failure.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/application/boundaries/register_user/registerUserInput.dart';
import 'package:flutter/foundation.dart' show required;

class RegisterUserUseCase implements IRegisterUser {
  IAuthRepository _authRepository;

  RegisterUserUseCase({@required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> execute(RegisterUserInput input) async {
    User newUser = User(
        semester: input.semester,
        password: input.password,
        campus: input.campus,
        academicProgram: input.academicProgram,
        typeOfDocument: input.typeOfDocument,
        rol: input.rol,
        name: input.name,
        email: input.email,
        document: input.document);

    final user = await _authRepository.register(newUser: newUser);

    return user.fold((err) => Left(err), (user) => Right(user));
  }
}
