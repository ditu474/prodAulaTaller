part of 'aulaAbierta_bloc.dart';

class AulaAbiertaState extends Equatable {
  final List<Service> services;
  final bool loading;
  final String error;

  const AulaAbiertaState({
    this.services,
    this.error = '',
    this.loading = false,
  });

  AulaAbiertaState copyWith({
    List<Service> services,
    String error,
    bool loading,
  }) {
    return AulaAbiertaState(
      services: services ?? this.services,
      error: error ?? this.error,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [services, error, loading];

  @override
  bool get stringify => true;
}
