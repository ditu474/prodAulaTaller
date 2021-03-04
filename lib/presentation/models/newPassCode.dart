import 'package:formz/formz.dart';

enum NewPassCodeError { invalid }

class NewPassCode extends FormzInput<String, NewPassCodeError> {
  const NewPassCode.pure() : super.pure('');
  const NewPassCode.dirty(String value) : super.dirty(value);

  static final _newPassCodeRegex = RegExp(
    r'^[a-zA-Z0-9]{6}$',
  );

  @override
  NewPassCodeError validator(String value) {
    return _newPassCodeRegex.hasMatch(value) ? null : NewPassCodeError.invalid;
  }
}
