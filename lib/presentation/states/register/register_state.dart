part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final Name name;
  final TypeOfDocument typeOfDocument;
  final Document document;
  final TypeOfUser typeOfUser;
  final Campus campus;
  final AcademicProgram academicProgram;
  final Semester semester;
  final ConfirmPassword confirmPassword;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String error;

  const RegisterState({
    this.name = const Name.pure(),
    this.typeOfDocument = const TypeOfDocument.pure(),
    this.document = const Document.pure(),
    this.typeOfUser = const TypeOfUser.pure(),
    this.campus = const Campus.pure(),
    this.academicProgram = const AcademicProgram.pure(),
    this.semester = const Semester.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.error = '',
  });

  RegisterState copyWith({
    Name name,
    TypeOfDocument typeOfDocument,
    Document document,
    TypeOfUser typeOfUser,
    Campus campus,
    AcademicProgram academicProgram,
    Semester semester,
    ConfirmPassword confirmPassword,
    Email email,
    Password password,
    FormzStatus status,
    String error,
  }) {
    return RegisterState(
      name: name ?? this.name,
      typeOfDocument: typeOfDocument ?? this.typeOfDocument,
      document: document ?? this.document,
      typeOfUser: typeOfUser ?? this.typeOfUser,
      campus: campus ?? this.campus,
      academicProgram: academicProgram ?? this.academicProgram,
      semester: semester ?? this.semester,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        name,
        typeOfDocument,
        typeOfUser,
        campus,
        academicProgram,
        document,
        semester,
        confirmPassword,
        email,
        password,
        status,
        error,
      ];

  @override
  bool get stringify => true;
}
