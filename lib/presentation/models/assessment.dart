import 'package:formz/formz.dart';

enum AssessmentValidationError { invalid }

class Assessment extends FormzInput<int, AssessmentValidationError> {
  const Assessment.pure() : super.pure(0);
  const Assessment.dirty([int value = 0]) : super.dirty(value);

  bool validate(int value) {
    if (value > 0 && value < 11)
      return true;
    else
      return false;
  }

  @override
  AssessmentValidationError validator(int value) {
    return validate(value) ? null : AssessmentValidationError.invalid;
  }
}
