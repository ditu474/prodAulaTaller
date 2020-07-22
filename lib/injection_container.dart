import 'package:aulataller/application/boundaries/add_assist/addAssist.dart';
import 'package:aulataller/application/boundaries/add_valuation.dart/iAddValuation.dart';
import 'package:aulataller/application/boundaries/get_all_services/iGetAllServices.dart';
import 'package:aulataller/application/boundaries/get_aula_abierta_services.dart/iGetAulaAbiertaServices.dart';
import 'package:aulataller/application/boundaries/get_current_user/iGetCurrentUser.dart';
import 'package:aulataller/application/boundaries/get_my_assists/get_my_assists.dart';
import 'package:aulataller/application/boundaries/get_my_valuations/iGetMyValuations.dart';
import 'package:aulataller/application/boundaries/get_token/iGetLastUser.dart';
import 'package:aulataller/application/boundaries/login_with_credentials/iLoginWithCredentials.dart';
import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:aulataller/application/boundaries/register_user/iRegisterUser.dart';
import 'package:aulataller/application/boundaries/reset_password/iReset_password.dart';
import 'package:aulataller/application/boundaries/save_user/iSaveUser.dart';
import 'package:aulataller/application/boundaries/send_recovery_token/iSend_recovery_token.dart';
import 'package:aulataller/application/usecases/addAssist.dart';
import 'package:aulataller/application/usecases/addNewValuation.dart';
import 'package:aulataller/application/usecases/deleteUserUseCase.dart';
import 'package:aulataller/application/usecases/getAulaAbiertaServices.dart';
import 'package:aulataller/application/usecases/getCurrentUser.dart';
import 'package:aulataller/application/usecases/getLastUserUseCase.dart';
import 'package:aulataller/application/usecases/getMyAssists.dart';
import 'package:aulataller/application/usecases/getMyValuations.dart';
import 'package:aulataller/application/usecases/loginWithCredentialsUseCase.dart';
import 'package:aulataller/application/usecases/openDynamicLinkUseCase.dart';
import 'package:aulataller/application/usecases/registerUserUseCase.dart';
import 'package:aulataller/application/usecases/reset_password.dart';
import 'package:aulataller/application/usecases/saveUserUseCase.dart';
import 'package:aulataller/application/usecases/sendRecoveryToken.dart';
import 'package:aulataller/application/usecases/updatePassword.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:aulataller/domain/repositories/iServicesRepository.dart';
import 'package:aulataller/infrastructure/datasources/iLocalDataSource.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/infrastructure/datasources/localDataSource.dart';
import 'package:aulataller/infrastructure/datasources/remoteDataSource.dart';
import 'package:aulataller/infrastructure/repositories/authRepository.dart';
import 'package:aulataller/infrastructure/repositories/serviceRepository.dart';
import 'package:aulataller/presentation/states/account/account_bloc.dart';
import 'package:aulataller/presentation/states/acomp_psico/psico_bloc.dart';
import 'package:aulataller/presentation/states/all_services/allServices_bloc.dart';
import 'package:aulataller/presentation/states/assists/assists_bloc.dart';
import 'package:aulataller/presentation/states/aula_abierta/aulaAbierta_bloc.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:aulataller/presentation/states/forgot_password/forgot_pass_bloc.dart';
import 'package:aulataller/presentation/states/home/home_bloc.dart';
import 'package:aulataller/presentation/states/login/login_bloc.dart';
import 'package:aulataller/presentation/states/register/register_bloc.dart';
import 'package:aulataller/presentation/states/sabios_gratin/sabios_bloc.dart';
import 'package:aulataller/utils/networkInfo.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application/boundaries/delete_user/iDeleteUser.dart';
import 'application/boundaries/update_password/iUpdatePassword.dart';
import 'application/usecases/getAllServices.dart';
import 'presentation/states/valuations/valuations_bloc.dart';

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
  getIt.registerLazySingleton<IServicesRepository>(() => ServiceRepository(
      networkInfo: getIt<INetworkInfo>(),
      remoteDataSource: getIt<IRemoteDataSource>(),
      localDataSource: getIt<ILocalDataSource>()));

  //application
  getIt.registerLazySingleton<ILoginWithCredentials>(() =>
      LoginWithCredentialsUseCase(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IOpenDynamicLink>(() => OpenDynamicLinkUseCase());
  getIt.registerLazySingleton<IDeleteUser>(
      () => DeleteUserUseCase(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IGetToken>(
      () => GetToken(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IRegisterUser>(
      () => RegisterUserUseCase(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<ISaveUser>(
      () => SaveUserUseCase(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IGetAulaAbiertaServices>(() =>
      GetAulaAbiertaServices(serviceRepository: getIt<IServicesRepository>()));
  getIt.registerLazySingleton<IGetAllServices>(
      () => GetAllServices(serviceRepository: getIt<IServicesRepository>()));
  getIt.registerLazySingleton<IGetCurrentUser>(
      () => GetCurrentUser(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IGetMyValuations>(
      () => GetMyValuations(serviceRepository: getIt<IServicesRepository>()));
  getIt.registerLazySingleton<IGetMyAssists>(
      () => GetMyAssists(serviceRepository: getIt<IServicesRepository>()));
  getIt.registerLazySingleton<IAddNewAssist>(
      () => AddNewAssist(serviceRepository: getIt<IServicesRepository>()));
  getIt.registerLazySingleton<IUpdatePassword>(
      () => UpdatePassword(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IAddNewValuation>(
      () => AddNewValuation(serviceRepository: getIt<IServicesRepository>()));
  getIt.registerLazySingleton<ISendRecoveryToken>(
      () => SendRecoveryToken(authRepository: getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IResetPassword>(
      () => ResetPassword(authRepository: getIt<IAuthRepository>()));

  //presentation
  getIt.registerFactory<LoginBloc>(() => LoginBloc(
      loginWithCredentials: getIt<ILoginWithCredentials>(),
      openDynamicLink: getIt<IOpenDynamicLink>(),
      saveUser: getIt<ISaveUser>()));
  getIt.registerFactory<AuthBloc>(() => AuthBloc(
      deleteLastUser: getIt<IDeleteUser>(), getLastUser: getIt<IGetToken>()));
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUser: getIt<IRegisterUser>(),
      saveUser: getIt<ISaveUser>(),
    ),
  );
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(openDynamicLink: getIt<IOpenDynamicLink>()),
  );
  getIt.registerFactory<PsicoBloc>(
    () => PsicoBloc(openDynamicLink: getIt<IOpenDynamicLink>()),
  );
  getIt.registerFactory<SabiosBloc>(
    () => SabiosBloc(openDynamicLink: getIt<IOpenDynamicLink>()),
  );
  getIt.registerFactory<AulaAbiertaBloc>(
    () => AulaAbiertaBloc(
        openDynamicLink: getIt<IOpenDynamicLink>(),
        getAulaAbiertaServices: getIt<IGetAulaAbiertaServices>()),
  );
  getIt.registerFactory<AllServicesBloc>(
    () => AllServicesBloc(getAllServices: getIt<IGetAllServices>()),
  );
  getIt.registerFactory<AccountBloc>(
    () => AccountBloc(
        getCurrentUser: getIt<IGetCurrentUser>(),
        updatePassword: getIt<IUpdatePassword>()),
  );
  getIt.registerFactory<ValuationsBloc>(
    () => ValuationsBloc(
        getMyValuations: getIt<IGetMyValuations>(),
        addNewValuation: getIt<IAddNewValuation>()),
  );
  getIt.registerFactory<AssistsBloc>(
    () => AssistsBloc(
        valuationsBloc: getIt<ValuationsBloc>(),
        addNewAssist: getIt<IAddNewAssist>(),
        getMyAssists: getIt<IGetMyAssists>()),
  );
  getIt.registerFactory<ForgotPassBloc>(() => ForgotPassBloc(
        resetPassword: getIt<IResetPassword>(),
        sendRecoveryToken: getIt<ISendRecoveryToken>(),
      ));
}
