import 'package:aulataller/application/boundaries/iUseCase.dart';
import 'package:aulataller/application/boundaries/register_user/registerUserInput.dart';
import 'package:aulataller/domain/entities/user.dart';

abstract class IRegisterUser extends IUseCase<RegisterUserInput,User>{}