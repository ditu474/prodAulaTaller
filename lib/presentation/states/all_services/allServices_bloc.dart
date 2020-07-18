import 'dart:async';

import 'package:aulataller/application/boundaries/get_all_services/iGetAllServices.dart';
import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:aulataller/domain/entities/service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'allServices_event.dart';
part 'allServices_state.dart';

class AllServicesBloc extends Bloc<AllServicesEvent, AllServicesState> {
  IGetAllServices _getAllServices;

  AllServicesBloc({@required getAllServices})
      : assert(
          getAllServices != null,
        ),
        _getAllServices = getAllServices;

  @override
  AllServicesState get initialState => AllServicesState();

  @override
  Stream<AllServicesState> mapEventToState(
    AllServicesEvent event,
  ) async* {
    if (event is FetchServices) {
      yield state.copyWith(loading: true);
      yield* _mapFetchServicesState();
    }
  }

  Stream<AllServicesState> _mapFetchServicesState() async* {
    final response = await _getAllServices.execute(null);
    if (response.isLeft()) {
      yield state.copyWith(
        error: response.fold((l) => l.message, (r) => null),
        loading: false,
      );
    } else if (response.isRight()) {
      yield state.copyWith(
        services: response.getOrElse(null),
        loading: false,
        error: '',
      );
    }
  }
}
