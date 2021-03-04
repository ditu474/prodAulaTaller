import 'package:formz/formz.dart';

enum CampusValidationError { invalid }

class Campus extends FormzInput<String, CampusValidationError> {
  final String typeOfUser;
  const Campus.pure({this.typeOfUser = ""}) : super.pure('');
  const Campus.dirty({String value, this.typeOfUser = ""}) : super.dirty(value);

  bool validate(String value) {
    if (this.typeOfUser != "externo") return value.isNotEmpty;
    return true;
  }

  @override
  CampusValidationError validator(String value) {
    return validate(value) ? null : CampusValidationError.invalid;
  }
}
