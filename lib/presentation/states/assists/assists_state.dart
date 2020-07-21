part of 'assists_bloc.dart';

class AssistsState extends Equatable {
  final List<Assist> assists;
  final bool loading;
  final String error;
  final Code code;
  final FormzStatus status;

  const AssistsState({
    this.assists,
    this.error = '',
    this.loading = false,
    this.code = const Code.pure(),
    this.status = FormzStatus.pure,
  });

  AssistsState copyWith({
    List<Assist> assists,
    String error,
    bool loading,
    Code code,
    FormzStatus status,
  }) {
    return AssistsState(
      assists: assists ?? this.assists,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      code: code ?? this.code,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        assists,
        error,
        loading,
        code,
        status,
      ];

  @override
  bool get stringify => true;
}
