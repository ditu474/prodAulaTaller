import 'package:aulataller/application/boundaries/iUseCase.dart';
import 'package:aulataller/domain/entities/valuation.dart';

abstract class IGetMyValuations extends IUseCase<Null, List<Valuation>> {}
