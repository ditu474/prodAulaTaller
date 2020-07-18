import 'dart:convert';

import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/value_objects/email.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/infrastructure/models/exception.dart';
import 'package:aulataller/infrastructure/models/serviceModel.dart';
import 'package:aulataller/infrastructure/models/userModel.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:http/http.dart' as http;

class RemoteDataSource implements IRemoteDataSource {
  final http.Client client;
  final String urlAPI = 'https://rich-solstice-283505.ue.r.appspot.com/';
  // final String urlAPI = 'http://192.168.0.11:3000/';

  RemoteDataSource({@required this.client});

  @override
  Future<User> loginWithCredentials({Email email, Password password}) async {
    try {
      Map<String, dynamic> body = {
        "correo": email.value,
        "password": password.value,
      };
      String url = urlAPI + 'api/v1/users/login';
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        return UserModel.fromMap(json.decode(response.body));
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<String> forgotPassword({Email email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<User> resetPassword({Password password, String resetToken}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<User> register({User newUser}) async {
    try {
      Map<String, dynamic> body = {
        "nombre": newUser.name.value,
        "tipoDocumento": newUser.typeOfDocument.value,
        "documento": newUser.document.value,
        "correo": newUser.email.value,
        "rol": newUser.rol.value,
        "sede": newUser.campus != null ? newUser.campus.value : null,
        "programaAcademico": newUser.academicProgram != null
            ? newUser.academicProgram.value
            : null,
        "semestre": newUser.semester != null ? newUser.semester.value : null,
        "password": newUser.password.value,
        "passwordConfirm": newUser.password.value
      };
      final response = await client.post(
        urlAPI + 'api/v1/users/signup',
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      if (response.statusCode == 201)
        return UserModel.fromMap(json.decode(response.body));
      else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<List<Service>> getAulaAbiertaServices(String token) async {
    try {
      final response = await client.get(
        urlAPI +
            'api/v1/servicios?sort=dia,horaInicio&idTipoServicio=5ea354ee10ff205aeb27684b',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return List.from(json.decode(response.body)["data"]["doc"])
            .map((e) => ServiceModel.fromMap(e))
            .toList();
      } else {
        throw CustomException(json.decode(response.body)["message"]);
      }
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
