import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { invalid }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;
  const ConfirmPassword.pure({this.password = ""}) : super.pure('');
  const ConfirmPassword.dirty({this.password = "", String value = ''})
      : super.dirty(value);

  bool validate(String value) => this.password == value;

  @override
  ConfirmPasswordValidationError validator(String value) {
    return validate(value) ? null : ConfirmPasswordValidationError.invalid;
  }
}
