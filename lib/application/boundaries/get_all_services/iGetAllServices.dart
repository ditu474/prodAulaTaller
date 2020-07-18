import 'package:aulataller/application/boundaries/iUseCase.dart';
import 'package:aulataller/domain/entities/service.dart';

abstract class IGetAllServices extends IUseCase<Null, List<Service>> {}
