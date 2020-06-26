import 'package:formz/formz.dart';

enum TypeOfUserValidationError { invalid }

class TypeOfUser extends FormzInput<String, TypeOfUserValidationError> {
  const TypeOfUser.pure() : super.pure('');
  const TypeOfUser.dirty([String value = '']) : super.dirty(value);

  @override
  TypeOfUserValidationError validator(String value) {
    return value.isNotEmpty ? null : TypeOfUserValidationError.invalid;
  }
}
