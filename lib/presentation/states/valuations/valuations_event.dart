part of 'valuations_bloc.dart';

@immutable
abstract class ValuationsEvent extends Equatable {
  const ValuationsEvent();

  @override
  List<Object> get props => [];
}

class FetchServices extends ValuationsEvent {}
