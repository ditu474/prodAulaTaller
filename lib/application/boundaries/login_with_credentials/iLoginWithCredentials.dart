import 'package:aulataller/application/boundaries/iUseCase.dart';
import 'package:aulataller/application/boundaries/login_with_credentials/loginCredentialsInput.dart';
import 'package:aulataller/domain/entities/user.dart';

abstract class ILoginWithCredentials extends IUseCase<LoginCredentialsInput,User>{}