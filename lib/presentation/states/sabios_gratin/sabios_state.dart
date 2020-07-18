part of 'sabios_bloc.dart';

@immutable
abstract class SabiosState extends Equatable {
  const SabiosState();

  @override
  List<Object> get props => [];
}

class SabiosInitial extends SabiosState {}

class SabiosLoading extends SabiosState {}

class SabiosSuccess extends SabiosState {}

class SabiosFailure extends SabiosState {
  final String errorMsg;

  const SabiosFailure(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
