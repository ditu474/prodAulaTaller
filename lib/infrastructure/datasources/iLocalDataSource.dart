import 'package:flutter/foundation.dart' show required;

abstract class ILocalDataSource{
  Future<String> getToken();

  Future<bool> setToken({@required String token});

  Future<bool> deleteToken();
}