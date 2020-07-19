import 'package:aulataller/domain/entities/user.dart';
import 'package:flutter/foundation.dart' show required;

class UserModel extends User {
  String email;
  String academicProgram;
  String campus;
  String document;
  String name;
  String rol;
  int semester;
  String typeOfDocument;
  String token;

  UserModel({
    @required this.token,
    @required this.email,
    this.academicProgram,
    this.campus,
    @required this.document,
    @required this.name,
    @required this.rol,
    this.semester,
    @required this.typeOfDocument,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String token) {
    return new UserModel(
      token: token,
      email: map["correo"],
      name: map["nombre"],
      typeOfDocument: map["tipoDocumento"],
      document: map["documento"],
      rol: map["rol"],
      campus: map["sede"],
      academicProgram: map["programaAcademico"],
      semester: map["semestre"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "token": this.token,
      "email": this.email,
      "name": this.name,
      "typeOfDocument": this.typeOfDocument,
      "document": this.document,
      "rol": this.rol,
      "campus": this.campus,
      "academicProgram": this.academicProgram,
      "semester": this.semester
    };
  }
}
