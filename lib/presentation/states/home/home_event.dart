part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CuadroDeMandoPressed extends HomeEvent {}

class RequestsFormPressed extends HomeEvent {}
