import 'package:formz/formz.dart';

enum AcademicProgramValidationError { invalid }

class AcademicProgram
    extends FormzInput<String, AcademicProgramValidationError> {
  final String typeOfUser;
  const AcademicProgram.pure({this.typeOfUser = ""}) : super.pure('');
  const AcademicProgram.dirty({String value, this.typeOfUser = ""})
      : super.dirty(value);

  bool validate(String value) {
    if (this.typeOfUser == "estudiante") return value.isNotEmpty;
    return true;
  }

  @override
  AcademicProgramValidationError validator(String value) {
    return validate(value) ? null : AcademicProgramValidationError.invalid;
  }
}
