part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class RegisterUserConfirmed extends RegisterEvent {}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

class PasswordConfirmChanged extends RegisterEvent {
  final String passwordConfirm;

  const PasswordConfirmChanged({@required this.passwordConfirm});

  @override
  List<Object> get props => [passwordConfirm];
}

class NameChanged extends RegisterEvent {
  final String name;

  const NameChanged({@required this.name});

  @override
  List<Object> get props => [name];
}

class TypeOfDocumentChanged extends RegisterEvent {
  final String typeOfDocument;

  const TypeOfDocumentChanged({@required this.typeOfDocument});

  @override
  List<Object> get props => [typeOfDocument];
}

class DocumentChanged extends RegisterEvent {
  final String document;

  const DocumentChanged({@required this.document});

  @override
  List<Object> get props => [document];
}

class TypeOfUserChanged extends RegisterEvent {
  final String typeOfUser;

  const TypeOfUserChanged({@required this.typeOfUser});

  @override
  List<Object> get props => [typeOfUser];
}

class CampusChanged extends RegisterEvent {
  final String campus;

  const CampusChanged({@required this.campus});

  @override
  List<Object> get props => [campus];
}

class AcademicProgramChanged extends RegisterEvent {
  final String academicProgram;

  const AcademicProgramChanged({@required this.academicProgram});

  @override
  List<Object> get props => [academicProgram];
}

class SemesterChanged extends RegisterEvent {
  final int semester;

  const SemesterChanged({@required this.semester});

  @override
  List<Object> get props => [semester];
}
