import 'package:aulataller/domain/entities/user.dart';
import 'package:flutter/foundation.dart' show required;

abstract class IEntityFactory{
  User newUser({
    @required String token
  });
}