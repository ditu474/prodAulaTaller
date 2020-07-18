part of 'allServices_bloc.dart';

@immutable
abstract class AllServicesEvent extends Equatable {
  const AllServicesEvent();

  @override
  List<Object> get props => [];
}

class FetchServices extends AllServicesEvent {}
