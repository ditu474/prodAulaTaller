part of 'assists_bloc.dart';

class AssistsState extends Equatable {
  final List<Assist> assists;
  final bool loading;
  final String error;
  final Code code;

  const AssistsState({
    this.assists,
    this.error = '',
    this.loading = false,
    this.code = const Code.pure(),
  });

  AssistsState copyWith({
    List<Assist> assists,
    String error,
    bool loading,
    Code code,
  }) {
    return AssistsState(
      assists: assists ?? this.assists,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      code: code ?? this.code,
    );
  }

  @override
  List<Object> get props => [assists, error, loading, code];

  @override
  bool get stringify => true;
}
