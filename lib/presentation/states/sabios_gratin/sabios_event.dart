part of 'sabios_bloc.dart';

@immutable
abstract class SabiosEvent extends Equatable {
  const SabiosEvent();

  @override
  List<Object> get props => [];
}

class CurrentSessionPressed extends SabiosEvent {}

class RepositoryPressed extends SabiosEvent {}

class FormPressed extends SabiosEvent {}
