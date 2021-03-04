import 'package:formz/formz.dart';

enum DetailValidationError { invalid }

class Detail extends FormzInput<String, DetailValidationError> {
  const Detail.pure() : super.pure('');
  const Detail.dirty([String value = '']) : super.dirty(value);

  bool _validate(String value) {
    if (value != null) {
      return value.length > -1 && value.length < 151;
    }
    return false;
  }

  @override
  DetailValidationError validator(String value) {
    return _validate(value) ? null : DetailValidationError.invalid;
  }
}
