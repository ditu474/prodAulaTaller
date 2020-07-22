part of 'assists_bloc.dart';

@immutable
abstract class AssistsEvent extends Equatable {
  const AssistsEvent();

  @override
  List<Object> get props => [];
}

class GetAssists extends AssistsEvent {}

class AddAssistButtonPressed extends AssistsEvent {}

class CodeChanged extends AssistsEvent {
  final String code;

  const CodeChanged({@required this.code});

  @override
  List<Object> get props => [code];
}

class AssistChange extends AssistsEvent {}
