import 'package:aulataller/domain/entities/user.dart';
import 'package:aulataller/domain/factories/iEntityFactory.dart';
import 'package:flutter/foundation.dart' show required;

class EntityFactory implements IEntityFactory{
  @override
  User newUser({@required String token}) {
    return User(token: token);
  }
}