import 'package:flutter/foundation.dart';

class User{
  String _token;

  User({@required String token}):this._token=token;

  String get token => this._token;
}