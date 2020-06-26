import 'dart:async';

import 'package:aulataller/application/boundaries/register_user/iRegisterUser.dart';
import 'package:aulataller/application/boundaries/register_user/registerUserInput.dart';
import 'package:aulataller/application/boundaries/save_user/iSaveUser.dart';
import 'package:aulataller/presentation/models/name.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import '../../models/models.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  IRegisterUser _registerUser;
  ISaveUser _saveUser;

  RegisterBloc({
    @required registerUser,
    @required saveUser,
  })  : assert(
          registerUser != null,
          saveUser != null,
        ),
        _registerUser = registerUser,
        _saveUser = saveUser;

  @override
  RegisterState get initialState => RegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is AcademicProgramChanged) {
      yield* _mapAcademicProgramChangedToState(event.academicProgram);
    } else if (event is CampusChanged) {
      yield* _mapCampusChangedToState(event.campus);
    } else if (event is PasswordConfirmChanged) {
      yield* _mapPasswordConfirmChangedToState(event.passwordConfirm);
    } else if (event is DocumentChanged) {
      yield* _mapDocumentChangedToState(event.document);
    } else if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is SemesterChanged) {
      yield* _mapSemesterChangedToState(event.semester);
    } else if (event is TypeOfDocumentChanged) {
      yield* _mapTypeOfDocumentChangedToState(event.typeOfDocument);
    } else if (event is TypeOfUserChanged) {
      yield* _mapTypeOfUserChangedToState(event.typeOfUser);
    } else if (event is RegisterUserConfirmed) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        bool validateStudent = state.typeOfUser.value == "estudiante";
        bool validateTeacher = state.typeOfUser.value == "docente";
        yield* _mapRegisterToState(
          academicProgram: validateStudent ? state.academicProgram.value : null,
          typeOfUser: state.typeOfUser.value,
          typeOfDocument: state.typeOfDocument.value,
          semester: validateStudent ? state.semester.value : null,
          password: state.password.value,
          name: state.name.value,
          email: state.email.value,
          document: state.document.value,
          campus:
              validateStudent || validateTeacher ? state.campus.value : null,
        );
      }
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String eventEmail) async* {
    final email = Email.dirty(eventEmail);
    yield state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.academicProgram,
        state.campus,
        state.confirmPassword,
        state.document,
        state.name,
        state.semester,
        state.typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(
      String eventPassword) async* {
    final password = Password.dirty(eventPassword);
    yield state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password,
        state.academicProgram,
        state.campus,
        state.confirmPassword,
        state.document,
        state.name,
        state.semester,
        state.typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapAcademicProgramChangedToState(
      String eventAcademicProgram) async* {
    final academicProgram = AcademicProgram.dirty(
      value: eventAcademicProgram,
      typeOfUser: state.typeOfUser.value,
    );
    yield state.copyWith(
      academicProgram: academicProgram,
      status: Formz.validate([
        state.email,
        state.password,
        academicProgram,
        state.campus,
        state.confirmPassword,
        state.document,
        state.name,
        state.semester,
        state.typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapCampusChangedToState(String eventCampus) async* {
    final campus = Campus.dirty(
      value: eventCampus,
      typeOfUser: state.typeOfUser.value,
    );
    yield state.copyWith(
      campus: campus,
      status: Formz.validate([
        state.email,
        state.password,
        state.academicProgram,
        campus,
        state.confirmPassword,
        state.document,
        state.name,
        state.semester,
        state.typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapPasswordConfirmChangedToState(
      String eventConfirmPassword) async* {
    final confirmPassword = ConfirmPassword.dirty(
      value: eventConfirmPassword,
      password: state.password.value,
    );
    yield state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate([
        state.email,
        state.password,
        state.academicProgram,
        state.campus,
        confirmPassword,
        state.document,
        state.name,
        state.semester,
        state.typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapDocumentChangedToState(
      String eventDocument) async* {
    final document = Document.dirty(eventDocument);
    yield state.copyWith(
      document: document,
      status: Formz.validate([
        state.email,
        state.password,
        state.academicProgram,
        state.campus,
        state.confirmPassword,
        document,
        state.name,
        state.semester,
        state.typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapNameChangedToState(String eventName) async* {
    final name = Name.dirty(eventName);
    yield state.copyWith(
      name: name,
      status: Formz.validate([
        state.email,
        state.password,
        state.academicProgram,
        state.campus,
        state.confirmPassword,
        state.document,
        name,
        state.semester,
        state.typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapSemesterChangedToState(int eventSemester) async* {
    final semester = Semester.dirty(
      value: eventSemester,
      typeOfUser: state.typeOfUser.value,
    );
    yield state.copyWith(
      semester: semester,
      status: Formz.validate([
        state.email,
        state.password,
        state.academicProgram,
        state.campus,
        state.confirmPassword,
        state.document,
        state.name,
        semester,
        state.typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapTypeOfDocumentChangedToState(
      String eventTypeOfDocument) async* {
    final typeOfDocument = TypeOfDocument.dirty(
      eventTypeOfDocument,
    );
    yield state.copyWith(
      typeOfDocument: typeOfDocument,
      status: Formz.validate([
        state.email,
        state.password,
        state.academicProgram,
        state.campus,
        state.confirmPassword,
        state.document,
        state.name,
        state.semester,
        typeOfDocument,
        state.typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapTypeOfUserChangedToState(
      String eventTypeOfUser) async* {
    final typeOfUser = TypeOfUser.dirty(
      eventTypeOfUser,
    );
    yield state.copyWith(
      typeOfUser: typeOfUser,
      status: Formz.validate([
        state.email,
        state.password,
        state.academicProgram,
        state.campus,
        state.confirmPassword,
        state.document,
        state.name,
        state.semester,
        state.typeOfDocument,
        typeOfUser
      ]),
    );
  }

  Stream<RegisterState> _mapRegisterToState(
      {String email,
      String password,
      String academicProgram,
      String campus,
      String document,
      String name,
      int semester,
      String typeOfDocument,
      String typeOfUser}) async* {
    var user = RegisterUserInput.createFromInputs(
        email: email,
        password: password,
        name: name,
        rol: typeOfUser,
        typeOfDocument: typeOfDocument,
        semester: semester,
        document: document,
        campus: campus,
        academicProgram: academicProgram);
    if (user.isLeft()) {
      yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: user.fold((l) => l.message, (r) => null));
    } else {
      var response = await _registerUser.execute(user.getOrElse(null));
      if (response.isRight()) {
        await _saveUser.execute(response.getOrElse(null));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } else {
        yield state.copyWith(
            status: FormzStatus.submissionFailure,
            error: response.fold((l) => l.message, (r) => null));
      }
    }
  }
}
