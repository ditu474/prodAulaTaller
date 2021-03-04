part of 'aulaAbierta_bloc.dart';

@immutable
abstract class AulaAbiertaEvent extends Equatable {
  const AulaAbiertaEvent();

  @override
  List<Object> get props => [];
}

class ItemPressed extends AulaAbiertaEvent {
  final String link;

  const ItemPressed(this.link);

  @override
  List<Object> get props => [link];
}

class FetchServices extends AulaAbiertaEvent {}
