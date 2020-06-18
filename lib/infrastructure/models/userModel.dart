import 'package:aulataller/domain/entities/user.dart';
import 'package:flutter/foundation.dart' show required;

class UserModel extends User{
  String token;

  UserModel({
    @required this.token
  });

  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(token: map["token"]);
  }

  Map<String,dynamic> toMap(){
    return {
      "token":this.token
    };
  }
}