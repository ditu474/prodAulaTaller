import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/value_objects/academicProgram.dart';
import 'package:aulataller/domain/value_objects/campus.dart';
import 'package:aulataller/domain/value_objects/document.dart';
import 'package:aulataller/domain/value_objects/email.dart';
import 'package:aulataller/domain/value_objects/name.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:aulataller/domain/value_objects/rol.dart';
import 'package:aulataller/domain/value_objects/semester.dart';
import 'package:aulataller/domain/value_objects/typeOfDocument.dart';
import 'package:flutter/foundation.dart' show required;

abstract class IEntityFactory{
  User newUser({
    String token,
    @required Email email,
    Password password,
    AcademicProgram academicProgram,
    Campus campus,
    @required Document document,
    @required Name name,
    @required Rol rol,
    Semester semester,
    @required TypeOfDocument typeOfDocument,
    });
}