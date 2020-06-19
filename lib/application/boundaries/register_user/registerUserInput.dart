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

class RegisterUserInput extends Equatable{
  final Email email;
  final Password password;
  final AcademicProgram academicProgram;
  final Campus campus;
  final Document document;
  final Name name;
  final Rol rol;
  final Semester semester;
  final TypeOfDocument typeOfDocument;

  RegisterUserInput._({
    this.email,
    this.password,
    this.academicProgram,
    this.campus,
    this.document,
    this.name,
    this.rol,
    this.semester,
    this.typeOfDocument
  });

  static Either<Failure,RegisterUserInput> createFromInputs({
    @required String email,
    @required String password,
    String academicProgram,
    String campus,
    dynamic document,
    @required String name,
    @required String rol,
    int semester,
    @required typeOfDocument
  }){
    if(email==null || password==null || name==null || rol==null || typeOfDocument==null){
      return Left(Failure('Invalid inputs'));
    }else{
      return Right(RegisterUserInput._(
        typeOfDocument:TypeOfDocument.create(typeOfDocument).getOrElse(null),
        semester: Semester.create(semester).getOrElse(null),
        rol: Rol.create(rol).getOrElse(null),
        password: Password.create(password).getOrElse(null),
        name: Name.create(name).getOrElse(null),
        academicProgram: AcademicProgram.create(academicProgram).getOrElse(null),
        email: Email.create(email).getOrElse(null),
        campus: Campus.create(campus).getOrElse(null),
        document: Document.create(document).getOrElse(null)
        )
      );
    }
  }

  @override
  List<Object> get props => [email,password,academicProgram,campus,document,
  name,rol,semester,typeOfDocument];
}