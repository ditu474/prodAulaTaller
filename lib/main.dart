import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/home/home_page.dart';
import 'package:aulataller/presentation/UI/home/splashScreen.dart';
import 'package:aulataller/presentation/UI/login/login_page.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as getInstances;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getInstances.setup();
  runApp(BlocProvider<AuthBloc>(
      create: (context) => getIt<AuthBloc>(), child: AulaTallerApp()));
}

class AulaTallerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.orange,
        fontFamily: 'Nunito',
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Mukta',
          ),
          bodyText2: TextStyle(
            fontFamily: 'Mukta',
          ),
        ),
      ),
      title: 'Aula Taller',
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginPage();
          }
          if (state is AuthenticationSuccess) {
            return HomePage();
          } else {
            context.bloc<AuthBloc>().add(AuthenticationStarted());
            return SplashScreen();
          }
        },
      ),
    );
  }
}
