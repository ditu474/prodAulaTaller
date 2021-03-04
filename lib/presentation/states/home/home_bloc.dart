import 'dart:async';

import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  IOpenDynamicLink _openDynamicLink;

  HomeBloc({@required openDynamicLink})
      : assert(openDynamicLink != null),
        _openDynamicLink = openDynamicLink;

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is CuadroDeMandoPressed) {
      yield HomeLoading();
      yield* _mapCuadroDeMandoState();
    } else if (event is RequestsFormPressed) {
      yield HomeLoading();
      yield* _mapRequestsFormState();
    }
  }

  Stream<HomeState> _mapCuadroDeMandoState() async* {
    final response = await _openDynamicLink.execute("null");
    if (response.isLeft()) {
      yield HomeFailure("No se logró abrir el cuadro de mando");
    } else {
      yield HomeSuccess();
    }
  }

  Stream<HomeState> _mapRequestsFormState() async* {
    final response = await _openDynamicLink.execute(
        "https://docs.google.com/forms/d/e/1FAIpQLSdpnFdZoyHpqRPeakbvziN8c5IosOqmbPNNlN1hasG5pZjliA/viewform");
    if (response.isLeft()) {
      yield HomeFailure("No se logró abrir el formulario");
    } else {
      yield HomeSuccess();
    }
  }
}
