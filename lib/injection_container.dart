import 'package:aulataller/application/boundaries/get_last_user/iGetLastUser.dart';
import 'package:aulataller/application/boundaries/login_with_credentials/iLoginWithCredentials.dart';
import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:aulataller/application/boundaries/register_user/iRegisterUser.dart';
import 'package:aulataller/application/boundaries/save_user/iSaveUser.dart';
import 'package:aulataller/application/usecases/deleteUserUseCase.dart';
import 'package:aulataller/application/usecases/getLastUserUseCase.dart';
import 'package:aulataller/application/usecases/loginWithCredentialsUseCase.dart';
import 'package:aulataller/application/usecases/openDynamicLinkUseCase.dart';
import 'package:aulataller/application/usecases/registerUserUseCase.dart';
import 'package:aulataller/application/usecases/saveUserUseCase.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:aulataller/infrastructure/datasources/iLocalDataSource.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/infrastructure/datasources/localDataSource.dart';
import 'package:aulataller/infrastructure/datasources/remoteDataSource.dart';
import 'package:aulataller/infrastructure/repositories/authRepository.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:aulataller/presentation/states/login/login_bloc.dart';
import 'package:aulataller/presentation/states/register/register_bloc.dart';
import 'package:aulataller/utils/networkInfo.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application/boundaries/delete_user/iDeleteUser.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  //external
  getIt.registerLazySingleton<Client>(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());

  //utils
  getIt.registerLazySingleton<INetworkInfo>(
      () => NetworkInfo(getIt<DataConnectionChecker>()));

  //infrastructure
  getIt.registerLazySingleton<IRemoteDataSource>(
      () => RemoteDataSource(client: getIt<Client>()));
  getIt.registerLazySingleton<ILocalDataSource>(
      () => LocalDataSource(sharedPreferences: getIt<SharedPreferences>()));
  getIt.registerLazySingleton<IAuthRepository>(() => AuthRepository(
      networkInfo: getIt<INetworkInfo>(),
      remoteDataSource: getIt<IRemoteDataSource>(),
      localDataSource: getIt<ILocalDataSource>()));

  //application
  getIt.registerLazySingleton<ILoginWithCredentials>(() =>
      LoginWithCredentialsUseCase(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IOpenDynamicLink>(() => OpenDynamicLinkUseCase());
  getIt.registerLazySingleton<IDeleteUser>(
      () => DeleteUserUseCase(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IGetLastUser>(
      () => GetLastUserUseCase(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IRegisterUser>(
      () => RegisterUserUseCase(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<ISaveUser>(
      () => SaveUserUseCase(authRepository: getIt<IAuthRepository>()));

  //presentation
  getIt.registerFactory<LoginBloc>(() => LoginBloc(
      loginWithCredentials: getIt<ILoginWithCredentials>(),
      openDynamicLink: getIt<IOpenDynamicLink>(),
      saveUser: getIt<ISaveUser>()));
  getIt.registerFactory<AuthBloc>(() => AuthBloc(
      deleteLastUser: getIt<IDeleteUser>(),
      getLastUser: getIt<IGetLastUser>()));
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUser: getIt<IRegisterUser>(),
      saveUser: getIt<ISaveUser>(),
    ),
  );
}
