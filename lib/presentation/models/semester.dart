import 'package:formz/formz.dart';

enum SemesterValidationError { invalid }

class Semester extends FormzInput<int, SemesterValidationError> {
  final String typeOfUser;
  const Semester.pure({this.typeOfUser = ""}) : super.pure(0);
  const Semester.dirty({int value, this.typeOfUser = ""}) : super.dirty(value);

  bool validate(int value) {
    if (this.typeOfUser == "estudiante") {
      if (value > 0 && value < 11)
        return true;
      else
        return false;
    }
    return true;
  }

  @override
  SemesterValidationError validator(int value) {
    return validate(value) ? null : SemesterValidationError.invalid;
  }
}
