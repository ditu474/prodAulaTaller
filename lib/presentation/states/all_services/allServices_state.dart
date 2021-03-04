part of 'allServices_bloc.dart';

class AllServicesState extends Equatable {
  final List<Service> services;
  final bool loading;
  final String error;

  const AllServicesState({
    this.services,
    this.error = '',
    this.loading = false,
  });

  AllServicesState copyWith({
    List<Service> services,
    String error,
    bool loading,
  }) {
    return AllServicesState(
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
