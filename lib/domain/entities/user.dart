import 'package:aulataller/domain/value_objects/academicProgram.dart';
import 'package:aulataller/domain/value_objects/campus.dart';
import 'package:aulataller/domain/value_objects/document.dart';
import 'package:aulataller/domain/value_objects/email.dart';
import 'package:aulataller/domain/value_objects/name.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:aulataller/domain/value_objects/rol.dart';
import 'package:aulataller/domain/value_objects/semester.dart';
import 'package:aulataller/domain/value_objects/typeOfDocument.dart';
import 'package:flutter/foundation.dart';

class User{
  Email _email;
  Password _password;
  AcademicProgram _academicProgram;
  Campus _campus;
  Document _document;
  Name _name;
  Rol _rol;
  Semester _semester;
  TypeOfDocument _typeOfDocument;
  String _token;

  User({
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
    })
    :this._token=token,
    this._email=email,
    this._password=password,
    this._academicProgram=academicProgram,
    this._campus=campus,
    this._document=document,
    this._name=name,
    this._rol=rol,
    this._semester=semester,
    this._typeOfDocument=typeOfDocument;

  String get token => this._token;

  Email get email => this._email;

  Password get password => this._password;

  AcademicProgram get academicProgram => this._academicProgram;

  Campus get campus => this._campus;

  Document get document => this._document;

  Name get name => this._name;

  Rol get rol => this._rol;
  
  Semester get semester => this._semester;

  TypeOfDocument get typeOfDocument => this._typeOfDocument;
}