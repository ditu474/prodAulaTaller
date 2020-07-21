import 'dart:async';

import 'package:aulataller/application/boundaries/add_assist/addAssist.dart';
import 'package:aulataller/application/boundaries/get_my_assists/get_my_assists.dart';
import 'package:aulataller/domain/entities/assist.dart';
import 'package:aulataller/presentation/models/code.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'assists_event.dart';
part 'assists_state.dart';

class AssistsBloc extends Bloc<AssistsEvent, AssistsState> {
  IGetMyAssists _getMyAssists;
  IAddNewAssist _addNewAssist;

  AssistsBloc({
    @required getMyAssists,
    @required addNewAssist,
  })  : assert(
          getMyAssists != null,
          addNewAssist != null,
        ),
        _getMyAssists = getMyAssists,
        _addNewAssist = addNewAssist;

  @override
  AssistsState get initialState => AssistsState();

  @override
  Stream<AssistsState> mapEventToState(
    AssistsEvent event,
  ) async* {
    if (event is GetAssists) {
      yield state.copyWith(loading: true);
      yield* _mapGetAssistsState();
    } else if (event is AddAssistButtonPressed) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      yield* _mapAddAssistState();
    } else if (event is CodeChanged) {
      yield* _mapCodeChangeState(event.code);
    }
  }

  Stream<AssistsState> _mapGetAssistsState() async* {
    final response = await _getMyAssists.execute(null);
    if (response.isLeft()) {
      yield state.copyWith(
        error: response.fold((l) => l.message, (r) => null),
        loading: false,
      );
    } else if (response.isRight()) {
      yield state.copyWith(
        assists: response.getOrElse(null),
        loading: false,
        error: '',
      );
    }
  }

  Stream<AssistsState> _mapAddAssistState() async* {
    final response = await _addNewAssist.execute(state.code.value);
    if (response.isLeft()) {
      yield state.copyWith(
        error: response.fold((l) => l.message, (r) => null),
        status: FormzStatus.submissionInProgress,
      );
    } else if (response.isRight()) {
      yield state.copyWith(
        status: FormzStatus.submissionSuccess,
        loading: true,
      );
      yield* _mapGetAssistsState();
    }
  }

  Stream<AssistsState> _mapCodeChangeState(String code) async* {
    final _code = Code.dirty(code);
    yield state.copyWith(
      code: _code,
      status: Formz.validate([_code]),
    );
  }
}
