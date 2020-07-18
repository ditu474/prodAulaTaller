import 'package:aulataller/domain/entities/user.dart';
// import 'package:aulataller/domain/value_objects/academicProgram.dart';
// import 'package:aulataller/domain/value_objects/campus.dart';
// import 'package:aulataller/domain/value_objects/document.dart';
// import 'package:aulataller/domain/value_objects/email.dart';
// import 'package:aulataller/domain/value_objects/name.dart';
// import 'package:aulataller/domain/value_objects/password.dart';
// import 'package:aulataller/domain/value_objects/rol.dart';
// import 'package:aulataller/domain/value_objects/semester.dart';
// import 'package:aulataller/domain/value_objects/typeOfDocument.dart';
import 'package:aulataller/domain/value_objects/token.dart';
import 'package:flutter/foundation.dart' show required;

class UserModel extends User {
  // Email email;
  // Password password;
  // AcademicProgram academicProgram;
  // Campus campus;
  // Document document;
  // Name name;
  // Rol rol;
  // Semester semester;
  // TypeOfDocument typeOfDocument;
  Token token;

  UserModel({
    @required this.token,
    // @required this.email,
    // this.password,
    // this.academicProgram,
    // this.campus,
    // @required this.document,
    // @required this.name,
    // @required this.rol,
    // this.semester,
    // @required this.typeOfDocument,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(token: Token.create(map["token"]).getOrElse(null));
    // email: Email.create(map["data"]["user"]["correo"]).getOrElse(null),
    // name: Name.create(map["data"]["user"]["nombre"]).getOrElse(null),
    // typeOfDocument:
    //     TypeOfDocument.create(map["data"]["user"]["tipoDocumento"])
    //         .getOrElse(null),
    // document:
    //     Document.create(map["data"]["user"]["documento"]).getOrElse(null),
    // rol: Rol.create(map["data"]["user"]["rol"]).getOrElse(null),
    // campus:
    //     Campus.create(map["data"]["user"]["sede"] ?? '').getOrElse(null),
    // academicProgram: AcademicProgram.create(
    //         map["data"]["user"]["programaAcademico"] ?? '')
    //     .getOrElse(null),
    // semester: Semester.create(map["data"]["user"]["semestre"] ?? '')
    //     .getOrElse(null));
  }

  Map<String, dynamic> toMap() {
    return {
      "token": this.token,
      // "email": this.email,
      // "name": this.name,
      // "typeOfDocument": this.typeOfDocument,
      // "document": this.document,
      // "rol": this.rol,
      // "campus": this.campus,
      // "academicProgram": this.academicProgram,
      // "semester": this.semester
    };
  }
}
