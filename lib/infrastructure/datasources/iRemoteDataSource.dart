import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/value_objects/email.dart';
import 'package:aulataller/domain/value_objects/password.dart';
import 'package:flutter/foundation.dart' show required;

abstract class IRemoteDataSource{
  Future<User> loginWithCredentials({@required Email email,@required Password password});
  Future<User> register({@required User newUser});
  Future<String> forgotPassword({@required Email email});
  Future<User> resetPassword({@required Password password, @required String resetToken});
}