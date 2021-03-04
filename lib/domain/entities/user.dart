import 'package:flutter/foundation.dart' show required;

class User {
  String _email;
  String _password;
  String _academicProgram;
  String _campus;
  String _document;
  String _name;
  String _rol;
  int _semester;
  String _typeOfDocument;
  String _token;

  User({
    String token,
    @required String email,
    String password,
    String academicProgram,
    String campus,
    @required String document,
    @required String name,
    @required String rol,
    int semester,
    @required String typeOfDocument,
  })  : this._token = token,
        this._email = email,
        this._password = password,
        this._academicProgram = academicProgram,
        this._campus = campus,
        this._document = document,
        this._name = name,
        this._rol = rol,
        this._semester = semester,
        this._typeOfDocument = typeOfDocument;

  String get token => this._token;

  String get email => this._email;

  String get password => this._password;

  String get academicProgram => this._academicProgram;

  String get campus => this._campus;

  String get document => this._document;

  String get name => this._name;

  String get rol => this._rol;

  int get semester => this._semester;

  String get typeOfDocument => this._typeOfDocument;
}
