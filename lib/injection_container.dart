import 'package:aulataller/application/boundaries/login_with_credentials/iLoginWithCredentials.dart';
import 'package:aulataller/application/boundaries/open_dynamic_link/iOpenDynamicLink.dart';
import 'package:aulataller/application/usecases/loginWithCredentialsUseCase.dart';
import 'package:aulataller/application/usecases/openDynamicLink.dart';
import 'package:aulataller/domain/repositories/iAuthRepository.dart';
import 'package:aulataller/infrastructure/datasources/iRemoteDataSource.dart';
import 'package:aulataller/infrastructure/datasources/remoteDataSource.dart';
import 'package:aulataller/infrastructure/repositories/authRepository.dart';
import 'package:aulataller/presentation/states/login/login_bloc.dart';
import 'package:aulataller/utils/networkInfo.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setup(){
  //external
  getIt.registerLazySingleton<Client>(() => http.Client());
  getIt.registerLazySingletonAsync<SharedPreferences>(() async =>
    await SharedPreferences.getInstance());
  getIt.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());

  //utils
  getIt.registerLazySingleton<INetworkInfo>(()=> NetworkInfo(getIt<DataConnectionChecker>()));

  //infrastructure
  getIt.registerLazySingleton<IRemoteDataSource>(() => RemoteDataSource(client: getIt<Client>()));
  getIt.registerLazySingleton<IAuthRepository>(()=> AuthRepository(
    networkInfo: getIt<INetworkInfo>(),
    remoteDataSource: getIt<IRemoteDataSource>())
    );

  //application
  getIt.registerLazySingleton<ILoginWithCredentials>(() => 
  LoginWithCredentialsUseCase(authRepository:getIt<IAuthRepository>()));
  getIt.registerLazySingleton<IOpenDynamicLink>(() => 
  OpenDynamicLink());

  //presentation
  getIt.registerFactory<LoginBloc>(()=>LoginBloc(
    loginWithCredentials: getIt<ILoginWithCredentials>(),
    openDynamicLink: getIt<IOpenDynamicLink>()));
}