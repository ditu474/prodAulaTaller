part of 'valuations_bloc.dart';

class ValuationsState extends Equatable {
  final List<Valuation> valuations;
  final bool loading;
  final String error;
  final Assessment assessment;
  final Detail detail;
  final FormzStatus status;

  const ValuationsState({
    this.valuations,
    this.error = '',
    this.loading = false,
    this.assessment = const Assessment.pure(),
    this.detail = const Detail.pure(),
    this.status = FormzStatus.pure,
  });

  ValuationsState copyWith({
    List<Valuation> valuations,
    String error,
    bool loading,
    Assessment assessment,
    Detail detail,
    FormzStatus status,
  }) {
    return ValuationsState(
      valuations: valuations ?? this.valuations,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      assessment: assessment ?? this.assessment,
      detail: detail ?? this.detail,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        valuations,
        error,
        loading,
        assessment,
        detail,
        status,
      ];

  @override
  bool get stringify => true;
}
