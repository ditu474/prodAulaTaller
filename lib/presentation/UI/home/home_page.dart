import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/home/servicesSection.dart';
import 'package:aulataller/presentation/UI/home/utilitySection.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:aulataller/presentation/states/home/home_bloc.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return Scaffold(
            body: BlocProvider<HomeBloc>(
              create: (context) => getIt<HomeBloc>(),
              child: Body(),
            ),
          );
        } else {
          return NotAuthenticaded();
        }
      },
    );
  }
}

class NotAuthenticaded extends StatelessWidget {
  const NotAuthenticaded({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'No se encontró un usuario registrado, ingresa de nuevo.',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          RaisedButton(
            child: Text('Salir'),
            onPressed: () {
              context.bloc<AuthBloc>().add(AuthenticationLoggedOut());
            },
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return DefaultBackground(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.widthPercent(5),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                ServicesSection(),
                UtilitySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
