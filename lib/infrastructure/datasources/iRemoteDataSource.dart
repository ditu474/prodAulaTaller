import 'package:aulataller/domain/entities/assist.dart';
import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:flutter/foundation.dart' show required;

abstract class IRemoteDataSource {
  Future<User> loginWithCredentials(
      {@required String email, @required String password});
  Future<User> register({@required User newUser});
  Future<String> sendResetToken({@required String email});
  Future<User> resetPassword(
      {@required String password, @required String resetToken});
  Future<String> updatePassword(
      {@required String currentPassword,
      @required String newPassword,
      @required String token});
  Future<List<AulaAbiertaService>> getAulaAbiertaServices(String token);
  Future<List<Service>> getAllServices(String token);
  Future<List<Valuation>> getMyValuations(String token);
  Future<List<Assist>> getMyAssists(String token);
  Future<User> getUser(String token);
  Future<Assist> addNewAssist({@required String code, @required String token});
  Future<Valuation> addValuation(
      {@required String assistId,
      @required int valuation,
      String detail,
      @required String token});
}
