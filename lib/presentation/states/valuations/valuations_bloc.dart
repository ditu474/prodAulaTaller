import 'dart:async';

import 'package:aulataller/application/boundaries/get_my_valuations/iGetMyValuations.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'valuations_event.dart';
part 'valuations_state.dart';

class ValuationsBloc extends Bloc<ValuationsEvent, ValuationsState> {
  IGetMyValuations _getMyValuations;

  ValuationsBloc({@required getMyValuations})
      : assert(
          getMyValuations != null,
        ),
        _getMyValuations = getMyValuations;

  @override
  ValuationsState get initialState => ValuationsState();

  @override
  Stream<ValuationsState> mapEventToState(
    ValuationsEvent event,
  ) async* {
    if (event is FetchServices) {
      yield state.copyWith(loading: true);
      yield* _mapFetchServicesState();
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
}
