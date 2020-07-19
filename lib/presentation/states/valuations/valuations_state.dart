part of 'valuations_bloc.dart';

class ValuationsState extends Equatable {
  final List<Valuation> valuations;
  final bool loading;
  final String error;

  const ValuationsState({
    this.valuations,
    this.error = '',
    this.loading = false,
  });

  ValuationsState copyWith({
    List<Valuation> valuations,
    String error,
    bool loading,
  }) {
    return ValuationsState(
      valuations: valuations ?? this.valuations,
      error: error ?? this.error,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [valuations, error, loading];

  @override
  bool get stringify => true;
}
