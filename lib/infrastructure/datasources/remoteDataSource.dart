import 'dart:convert';

import 'package:aulataller/domain/entities/assist.dart';
import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/infrastructure/models/assistsModel.dart';
import 'package:aulataller/infrastructure/models/aulaAbiertaServiceModel.dart';
import 'package:aulataller/infrastructure/models/exception.dart';
import 'package:aulataller/infrastructure/models/serviceModel.dart';
import 'package:aulataller/infrastructure/models/userModel.dart';
import 'package:aulataller/infrastructure/models/valuationModel.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:http/http.dart' as http;

class RemoteDataSource implements IRemoteDataSource {
  final http.Client client;
  final String urlAPI = 'https://aulatallerapi-kkt6dnisqq-ue.a.run.app/api/v1/';
  /* 'http://192.168.0.9:3000/api/v1/'; */

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
  Future<String> sendResetToken({String email}) async {
    try {
      String url = urlAPI + 'users/forgotPassword';
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({"correo": email}),
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body["status"];
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<User> resetPassword({String password, String resetToken}) async {
    try {
      String url = urlAPI + 'users/resetPassword/$resetToken';
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "password": password,
          "passwordConfirm": password,
        }),
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
        urlAPI + 'valoracion/me?sort=-fecha',
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

  @override
  Future<List<Assist>> getMyAssists(String token) async {
    try {
      final response = await client.get(
        urlAPI + 'asistencia/me?sort=-fecha',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return List.from(json.decode(response.body)["data"]["doc"])
            .map((element) => AssistModel.fromMap(element))
            .toList();
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<Assist> addNewAssist({String code, String token}) async {
    try {
      final response = await client.post(
        urlAPI + 'asistencia',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"codigo": code}),
      );
      if (response.statusCode == 201) {
        return AssistModel(
            date: null,
            inCharge: null,
            typeOfService: null,
            valued: null,
            id: null);
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<String> updatePassword(
      {String currentPassword, String newPassword, String token}) async {
    try {
      final response = await client.post(
        urlAPI + 'users/updateMyPassword',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "passwordCurrent": currentPassword,
          "password": newPassword,
          "passwordConfirm": newPassword,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)["token"];
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<Valuation> addValuation({
    String assistId,
    int valuation,
    String detail,
    String token,
  }) async {
    try {
      final response = await client.post(
        urlAPI + 'valoracion',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "idAsistencia": assistId,
          "valoracion": valuation,
          "detalle": detail,
        }),
      );
      if (response.statusCode == 201) {
        return ValuationModel(
          attendanceDay: null,
          id: null,
          inCharge: null,
          typeOfService: null,
          valuation: null,
          detail: null,
        );
      } else
        throw CustomException(json.decode(response.body)["message"]);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
