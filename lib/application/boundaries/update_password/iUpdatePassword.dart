import 'package:aulataller/application/boundaries/iUseCase.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:equatable/equatable.dart';

abstract class IUpdatePassword extends IUseCase<UpdatePasswordInput, String> {}

class UpdatePasswordInput extends Equatable {
  final String currentPassword;
  final String newPassword;

  UpdatePasswordInput(
      {@required this.currentPassword, @required this.newPassword});

  @override
  List<Object> get props => [currentPassword, newPassword];
}
