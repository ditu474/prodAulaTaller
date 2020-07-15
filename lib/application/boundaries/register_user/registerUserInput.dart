import 'package:aulataller/domain/value_objects/academicProgram.dart';
import 'package:aulataller/domain/value_objects/campus.dart';
import 'package:aulataller/domain/value_objects/document.dart';
import 'package:aulataller/domain/value_objects/email.dart';
import 'package:aulataller/domain/value_objects/failure.dart';
import 'package:aulataller/domain/value_objects/name.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:aulataller/domain/value_objects/rol.dart';
import 'package:aulataller/domain/value_objects/semester.dart';
import 'package:aulataller/domain/value_objects/typeOfDocument.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show required;

class RegisterUserInput extends Equatable {
  final Email email;
  final Password password;
  final AcademicProgram academicProgram;
  final Campus campus;
  final Document document;
  final Name name;
  final Rol rol;
  final Semester semester;
  final TypeOfDocument typeOfDocument;

  RegisterUserInput._(
      {this.email,
      this.password,
      this.academicProgram,
      this.campus,
      this.document,
      this.name,
      this.rol,
      this.semester,
      this.typeOfDocument});

  static Either<Failure, RegisterUserInput> createFromInputs(
      {@required String email,
      @required String password,
      String academicProgram,
      String campus,
      dynamic document,
      @required String name,
      @required String rol,
      int semester,
      @required typeOfDocument}) {
    if (email == null ||
        password == null ||
        name == null ||
        rol == null ||
        typeOfDocument == null) {
      return Left(Failure('Invalid inputs'));
    } else {
      return Right(RegisterUserInput._(
          typeOfDocument:
              TypeOfDocument.create(typeOfDocument).fold((l) => null, (r) => r),
          semester: Semester.create(semester).fold((l) => null, (r) => r),
          rol: Rol.create(rol).fold((l) => null, (r) => r),
          password: Password.create(password).fold((l) => null, (r) => r),
          name: Name.create(name).fold((l) => null, (r) => r),
          academicProgram: AcademicProgram.create(academicProgram)
              .fold((l) => null, (r) => r),
          email: Email.create(email).fold((l) => null, (r) => r),
          campus: Campus.create(campus).fold((l) => null, (r) => r),
          document: Document.create(document).fold((l) => null, (r) => r)));
    }
  }

  @override
  List<Object> get props => [
        email,
        password,
        academicProgram,
        campus,
        document,
        name,
        rol,
        semester,
        typeOfDocument
      ];
}
