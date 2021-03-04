import 'package:formz/formz.dart';

enum CodeError { invalid }

class Code extends FormzInput<String, CodeError> {
  const Code.pure() : super.pure('');
  const Code.dirty(String value) : super.dirty(value);

  static final _codeRegex = RegExp(
    r'^[a-zA-Z0-9]{4,20}$',
  );

  @override
  CodeError validator(String value) {
    return _codeRegex.hasMatch(value) ? null : CodeError.invalid;
  }
}
