part of 'psico_bloc.dart';

@immutable
abstract class PsicoEvent extends Equatable {
  const PsicoEvent();

  @override
  List<Object> get props => [];
}

class ClaudiaButtonPressed extends PsicoEvent {}

class YennyButtonPressed extends PsicoEvent {}
