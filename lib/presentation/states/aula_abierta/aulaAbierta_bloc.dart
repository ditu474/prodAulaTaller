import 'dart:async';

import 'package:aulataller/application/boundaries/get_aula_abierta_services.dart/iGetAulaAbiertaServices.dart';
import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'aulaAbierta_event.dart';
part 'aulaAbierta_state.dart';

class AulaAbiertaBloc extends Bloc<AulaAbiertaEvent, AulaAbiertaState> {
  IOpenDynamicLink _openDynamicLink;
  IGetAulaAbiertaServices _getAulaAbiertaServices;

  AulaAbiertaBloc({@required openDynamicLink, @required getAulaAbiertaServices})
      : assert(
          openDynamicLink != null,
          getAulaAbiertaServices != null,
        ),
        _openDynamicLink = openDynamicLink,
        _getAulaAbiertaServices = getAulaAbiertaServices;

  @override
  AulaAbiertaState get initialState => AulaAbiertaInitial();

  @override
  Stream<AulaAbiertaState> mapEventToState(
    AulaAbiertaEvent event,
  ) async* {
    if (event is FetchServices) {
      yield AulaAbiertaLoading();
      yield* _mapFetchServicesState();
    } else if (event is ItemPressed) {
      yield AulaAbiertaLoading();
      yield* _mapItemPressedState(event.link);
    }
  }

  Stream<AulaAbiertaState> _mapFetchServicesState() async* {
    final response = await _getAulaAbiertaServices.execute(null);
    if (response.isLeft()) {
      yield AulaAbiertaFailure(response.fold((l) => l.message, (r) => null));
    } else if (response.isRight()) {
      yield AulaAbiertaSuccess(response.getOrElse(null));
    }
  }

  Stream<AulaAbiertaState> _mapItemPressedState(String link) async* {
    if (link == null) {
      yield AulaAbiertaFailure(
          "Este servicio no tiene una reunión de Google Meet asociada");
    } else {
      final response = await _openDynamicLink.execute(link);
      if (response.isLeft()) {
        yield AulaAbiertaFailure("No se logró abrir Google Meet");
      }
    }
  }
}
