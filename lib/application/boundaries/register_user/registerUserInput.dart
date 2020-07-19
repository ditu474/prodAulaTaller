import 'package:equatable/equatable.dart';

class RegisterUserInput extends Equatable {
  final String email;
  final String password;
  final String academicProgram;
  final String campus;
  final String document;
  final String name;
  final String rol;
  final int semester;
  final String typeOfDocument;

  RegisterUserInput(
      {this.email,
      this.password,
      this.academicProgram,
      this.campus,
      this.document,
      this.name,
      this.rol,
      this.semester,
      this.typeOfDocument});

  @override
  List<Object> get props => [
        email,
        password,
        academicProgram,
        campus,
        document,
        name,
        rol,
        semester,
        typeOfDocument
      ];
}
