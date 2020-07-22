part of 'valuations_bloc.dart';

@immutable
abstract class ValuationsEvent extends Equatable {
  const ValuationsEvent();

  @override
  List<Object> get props => [];
}

class FetchServices extends ValuationsEvent {}

class AddValuation extends ValuationsEvent {
  final String assistId;

  const AddValuation(this.assistId);

  @override
  List<Object> get props => [assistId];
}

class AssessmentChange extends ValuationsEvent {
  final int assessment;

  const AssessmentChange(this.assessment);

  @override
  List<Object> get props => [assessment];
}

class DetailChange extends ValuationsEvent {
  final String detail;

  const DetailChange(this.detail);

  @override
  List<Object> get props => [detail];
}
