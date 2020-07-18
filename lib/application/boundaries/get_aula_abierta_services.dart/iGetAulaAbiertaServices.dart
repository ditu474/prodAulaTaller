import 'package:aulataller/application/boundaries/iUseCase.dart';
import 'package:aulataller/domain/entities/aulaAbiertaService.dart';

abstract class IGetAulaAbiertaServices
    extends IUseCase<Null, List<AulaAbiertaService>> {}
