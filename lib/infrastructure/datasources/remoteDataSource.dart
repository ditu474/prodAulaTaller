import 'dart:convert';

import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/infrastructure/models/exception.dart';
import 'package:aulataller/infrastructure/models/aulaAbiertaServiceModel.dart';
import 'package:aulataller/infrastructure/models/serviceModel.dart';
import 'package:aulataller/infrastructure/models/userModel.dart';
import 'package:aulataller/infrastructure/models/valuationModel.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:http/http.dart' as http;

class RemoteDataSource implements IRemoteDataSource {
  final http.Client client;
  final String urlAPI = 'https://rich-solstice-283505.ue.r.appspot.com/api/v1/';
  // final String urlAPI = 'http://192.168.0.11:3000/';

  RemoteDataSource({@required this.client});

  @override
  Future<User> loginWithCredentials({String email, String password}) async {
    try {
      Map<String, dynamic> body = {
        "correo": email,
        "password": password,
      };
      String url = urlAPI + 'users/login';
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return UserModel.fromMap(body["data"]["user"], body["token"]);
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<String> forgotPassword({String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<User> resetPassword({String password, String resetToken}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<User> register({User newUser}) async {
    try {
      Map<String, dynamic> body = {
        "nombre": newUser.name,
        "tipoDocumento": newUser.typeOfDocument,
        "documento": newUser.document,
        "correo": newUser.email,
        "rol": newUser.rol,
        "sede": newUser.campus,
        "programaAcademico": newUser.academicProgram,
        "semestre": newUser.semester,
        "password": newUser.password,
        "passwordConfirm": newUser.password
      };
      final response = await client.post(
        urlAPI + 'users/signup',
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return UserModel.fromMap(body["data"]["user"], body["token"]);
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<List<AulaAbiertaService>> getAulaAbiertaServices(String token) async {
    try {
      final response = await client.get(
        urlAPI +
            'servicios?sort=dia,horaInicio&idTipoServicio=5ea354ee10ff205aeb27684b',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return List.from(json.decode(response.body)["data"]["doc"])
            .map((service) => AulaAbiertaServiceModel.fromMap(service))
            .toList();
      } else {
        throw CustomException(json.decode(response.body)["message"]);
      }
    } catch (err) {
      throw CustomException(err.toString());
    }
  }

  @override
  Future<List<Service>> getAllServices(String token) async {
    try {
      final response = await client.get(
        urlAPI + 'tiposervicio?sort=nombre',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return List.from(json.decode(response.body)["data"]["doc"])
            .map((service) => ServiceModel.fromMap(service))
            .toList();
      } else {
        throw CustomException(json.decode(response.body)["message"]);
      }
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<User> getUser(String token) async {
    try {
      final response = await client.get(
        urlAPI + 'users/me',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return UserModel.fromMap(body["data"]["doc"], token);
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<List<Valuation>> getMyValuations(String token) async {
    try {
      final response = await client.get(
        urlAPI + 'valoracion/me',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return List.from(json.decode(response.body)["data"]["doc"])
            .map((element) => ValuationModel.fromMap(element))
            .toList();
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
