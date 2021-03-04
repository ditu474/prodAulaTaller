part of 'psico_bloc.dart';

@immutable
abstract class PsicoState extends Equatable {
  const PsicoState();

  @override
  List<Object> get props => [];
}

class PsicoInitial extends PsicoState {}

class PsicoLoading extends PsicoState {}

class PsicoSuccess extends PsicoState {}

class PsicoFailure extends PsicoState {
  final String errorMsg;

  const PsicoFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
