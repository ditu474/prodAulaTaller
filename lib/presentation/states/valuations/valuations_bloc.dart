import 'dart:async';

import 'package:aulataller/application/boundaries/add_valuation.dart/iAddValuation.dart';
import 'package:aulataller/application/boundaries/get_my_valuations/iGetMyValuations.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:aulataller/presentation/models/assessment.dart';
import 'package:aulataller/presentation/models/detail.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'valuations_event.dart';
part 'valuations_state.dart';

class ValuationsBloc extends Bloc<ValuationsEvent, ValuationsState> {
  IGetMyValuations _getMyValuations;
  IAddNewValuation _addNewValuation;

  ValuationsBloc({
    @required getMyValuations,
    @required addNewValuation,
  })  : assert(
          getMyValuations != null,
          addNewValuation != null,
        ),
        _getMyValuations = getMyValuations,
        _addNewValuation = addNewValuation;

  @override
  ValuationsState get initialState => ValuationsState();

  @override
  Stream<ValuationsState> mapEventToState(
    ValuationsEvent event,
  ) async* {
    if (event is FetchServices) {
      yield state.copyWith(loading: true);
      yield* _mapFetchServicesState();
    } else if (event is AddValuation) {
      yield* _mapAddNewValuationState(event.assistId);
    } else if (event is AssessmentChange) {
      yield* _mapAssessmentChangeState(event.assessment);
    } else if (event is DetailChange) {
      yield* _mapDetailChangeState(event.detail);
    }
  }

  Stream<ValuationsState> _mapFetchServicesState() async* {
    final response = await _getMyValuations.execute(null);
    if (response.isLeft()) {
      yield state.copyWith(
        error: response.fold((l) => l.message, (r) => null),
        loading: false,
      );
    } else if (response.isRight()) {
      yield state.copyWith(
        valuations: response.getOrElse(null),
        loading: false,
        error: '',
      );
    }
  }

  Stream<ValuationsState> _mapAddNewValuationState(String assistId) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    final input = AddNewValuationInput(
      assistId: assistId,
      valuation: state.assessment.value,
      detail: state.detail.value,
    );
    final response = await _addNewValuation.execute(input);
    if (response.isLeft()) {
      yield state.copyWith(
        error: response.fold((l) => l.message, (r) => null),
        status: FormzStatus.submissionFailure,
      );
    } else if (response.isRight()) {
      yield state.copyWith(
        status: FormzStatus.submissionSuccess,
        error: '',
      );
    }
  }

  Stream<ValuationsState> _mapAssessmentChangeState(int assessment) async* {
    final _assessment = Assessment.dirty(assessment);
    yield state.copyWith(
      assessment: _assessment,
      status: Formz.validate([_assessment]),
    );
  }

  Stream<ValuationsState> _mapDetailChangeState(String detail) async* {
    final _detail = Detail.dirty(detail);
    yield state.copyWith(
      detail: _detail,
      status: Formz.validate([_detail]),
    );
  }
}
