import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  static final _nameRegex =
      RegExp(r"^[a-zA-ZÀ-ú]{3,}(([',. -][a-zA-ZÀ-ú])?[a-zA-ZÀ-ú]*)*$");

  @override
  NameValidationError validator(String value) {
    return _nameRegex.hasMatch(value) ? null : NameValidationError.invalid;
  }
}
