import 'dart:async';

import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'sabios_event.dart';
part 'sabios_state.dart';

class SabiosBloc extends Bloc<SabiosEvent, SabiosState> {
  IOpenDynamicLink _openDynamicLink;

  SabiosBloc({@required openDynamicLink})
      : assert(openDynamicLink != null),
        _openDynamicLink = openDynamicLink;

  @override
  SabiosState get initialState => SabiosInitial();

  @override
  Stream<SabiosState> mapEventToState(
    SabiosEvent event,
  ) async* {
    if (event is CurrentSessionPressed) {
      yield SabiosLoading();
      yield* _mapCurrentSessionState();
    } else if (event is RepositoryPressed) {
      yield SabiosLoading();
      yield* _mapRepositoryState();
    } else if (event is FormPressed) {
      yield SabiosLoading();
      yield* _mapFormState();
    }
  }

  Stream<SabiosState> _mapCurrentSessionState() async* {
    final response =
        await _openDynamicLink.execute("https://meet.google.com/pkk-reor-cae");
    if (response.isLeft()) {
      yield SabiosFailure("No se logró abrir la sesión actual");
    } else {
      yield SabiosSuccess();
    }
  }

  Stream<SabiosState> _mapRepositoryState() async* {
    final response = await _openDynamicLink.execute(
        "https://drive.google.com/drive/folders/1ogBIWWhENtKklaYWIW7wlcgyifG5TN2B");
    if (response.isLeft()) {
      yield SabiosFailure("No se logró abrir el repositorio");
    } else {
      yield SabiosSuccess();
    }
  }

  Stream<SabiosState> _mapFormState() async* {
    final response =
        await _openDynamicLink.execute("https://forms.gle/684HrrfU94KBVGneA");
    if (response.isLeft()) {
      yield SabiosFailure("No se logró abrir el formulario");
    } else {
      yield SabiosSuccess();
    }
  }
}
