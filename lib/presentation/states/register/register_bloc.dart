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
        bool isStudent = state.typeOfUser.value == "estudiante";
        bool isTeacher = state.typeOfUser.value == "docente";
        yield* _mapRegisterToState(
          academicProgram: isStudent ? state.academicProgram?.value : null,
          typeOfUser: state.typeOfUser.value,
          typeOfDocument: state.typeOfDocument?.value,
          semester: isStudent ? state.semester?.value : null,
          password: state.password.value,
          name: state.name.value,
          email: state.email.value,
          document: state.document.value,
          campus: isStudent || isTeacher ? state.campus?.value : null,
        );
      }
    }
    yield* _mapTypeOfUserChangedToState(state.typeOfUser.value);
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
    final confirmPassword = ConfirmPassword.dirty(
      value: state.confirmPassword.value,
      password: eventPassword,
    );
    yield state.copyWith(
      password: password,
      confirmPassword: confirmPassword,
      status: Formz.validate([
        state.email,
        password,
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
    final document = Document.dirty(
      value: eventDocument,
      typeOfDocument: state.typeOfDocument.value,
    );
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
    final document = Document.dirty(
        value: state.document.value, typeOfDocument: typeOfDocument.value);
    yield state.copyWith(
      typeOfDocument: typeOfDocument,
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

    if (typeOfUser.value == "estudiante") {
      yield* _mapAcademicProgramChangedToState(state.academicProgram.value);
      yield* _mapSemesterChangedToState(state.semester.value);
      yield* _mapCampusChangedToState(state.campus.value);
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
    } else if (typeOfUser.value == "docente") {
      yield* _mapCampusChangedToState(state.campus.value);
      yield state.copyWith(
        typeOfUser: typeOfUser,
        status: Formz.validate([
          state.email,
          state.password,
          state.campus,
          state.confirmPassword,
          state.document,
          state.name,
          state.typeOfDocument,
          typeOfUser
        ]),
      );
    } else if (typeOfUser.value == "externo") {
      yield state.copyWith(
        typeOfUser: typeOfUser,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmPassword,
          state.document,
          state.name,
          state.typeOfDocument,
          typeOfUser
        ]),
      );
    }
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
    var user = RegisterUserInput(
        email: email,
        password: password,
        name: name,
        rol: typeOfUser,
        typeOfDocument: typeOfDocument,
        semester: semester,
        document: document,
        campus: campus,
        academicProgram: academicProgram);
    var response = await _registerUser.execute(user);
    if (response.isRight()) {
      final tokenSaved = await _saveUser.execute(response.getOrElse(null));
      if (tokenSaved.isLeft()) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: tokenSaved.fold((l) => l.message, (r) => null),
        );
      } else {
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    } else {
      yield state.copyWith(
          status: FormzStatus.submissionFailure,
          error: response.fold((l) => l.message, (r) => null));
    }
  }
}
