import 'package:aulataller/presentation/UI/home/servicesSection.dart';
import 'package:aulataller/presentation/UI/home/utilitySection.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.widthPercent(5),
                  vertical: responsive.heigthPercent(2),
                ),
                width: responsive.widthPercent(100),
                height: responsive.heigthPercent(100),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[300],
                      Colors.grey[500],
                      Colors.grey[300],
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
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
      },
    );
  }
}
