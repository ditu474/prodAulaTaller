part of 'aulaAbierta_bloc.dart';

@immutable
abstract class AulaAbiertaState extends Equatable {
  const AulaAbiertaState();

  @override
  List<Object> get props => [];
}

class AulaAbiertaInitial extends AulaAbiertaState {}

class AulaAbiertaLoading extends AulaAbiertaState {}

class AulaAbiertaSuccess extends AulaAbiertaState {
  final List<Service> services;

  const AulaAbiertaSuccess(this.services);

  @override
  List<Object> get props => [services];
}

class AulaAbiertaFailure extends AulaAbiertaState {
  final String errorMsg;

  const AulaAbiertaFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
