import 'package:aulataller/application/boundaries/iUseCase.dart';
import 'package:aulataller/domain/entities/valuation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show required;

abstract class IAddNewValuation
    extends IUseCase<AddNewValuationInput, Valuation> {}

class AddNewValuationInput extends Equatable {
  final String assistId;
  final int valuation;
  final String detail;

  const AddNewValuationInput(
      {@required this.assistId, @required this.valuation, this.detail});

  @override
  List<Object> get props => [assistId, valuation, detail];
}
