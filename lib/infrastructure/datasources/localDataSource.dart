import 'package:aulataller/infrastructure/datasources/iLocalDataSource.dart';
import 'package:aulataller/infrastructure/models/exception.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource implements ILocalDataSource{
  final SharedPreferences sharedPreferences;

  LocalDataSource({@required this.sharedPreferences});

  @override
  Future<String> getToken() {
    final token = sharedPreferences.get("token");
    if(token)
      return token;
    else  
      throw CustomException('No se logró recuperar el token');
  }

  @override
  Future<bool> setToken({@required String token}) async {
    try{
      final response = await sharedPreferences.setString("token", token);
      return response;
    }catch(e){
      throw CustomException('No se logró guardar el token');
    }
  }

  @override
  Future<bool> deletToken() async{
    try{
      final response = await sharedPreferences.remove("token");
      return response;
    }catch(e){
      throw CustomException('No se logró borrar el token');
    }
  }
}