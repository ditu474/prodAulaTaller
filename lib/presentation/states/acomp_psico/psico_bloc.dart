import 'dart:async';

import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'psico_event.dart';
part 'psico_state.dart';

class PsicoBloc extends Bloc<PsicoEvent, PsicoState> {
  IOpenDynamicLink _openDynamicLink;

  PsicoBloc({@required openDynamicLink})
      : assert(openDynamicLink != null),
        _openDynamicLink = openDynamicLink;

  @override
  PsicoState get initialState => PsicoInitial();

  @override
  Stream<PsicoState> mapEventToState(
    PsicoEvent event,
  ) async* {
    if (event is ClaudiaButtonPressed) {
      yield PsicoLoading();
      yield* _mapClaudiaButtonState();
    } else if (event is YennyButtonPressed) {
      yield PsicoLoading();
      yield* _mapYennyButtonState();
    }
  }

  Stream<PsicoState> _mapClaudiaButtonState() async* {
    final response =
        await _openDynamicLink.execute("whatsapp://send?phone=\$+573106923537");
    if (response.isLeft()) {
      yield PsicoFailure("No se logró abrir Whatsapp");
    } else {
      yield PsicoSuccess();
    }
  }

  Stream<PsicoState> _mapYennyButtonState() async* {
    final response =
        await _openDynamicLink.execute("whatsapp://send?phone=\$+573106923502");
    if (response.isLeft()) {
      yield PsicoFailure("No se logró abrir Whatsapp");
    } else {
      yield PsicoSuccess();
    }
  }
}
