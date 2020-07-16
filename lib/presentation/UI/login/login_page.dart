import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/login/loginForm.dart';
import 'package:aulataller/presentation/UI/login/logo.dart';
import 'package:aulataller/presentation/UI/login/socialMedia.dart';
import 'package:aulataller/presentation/UI/register/register_page.dart';
import 'package:aulataller/presentation/UI/widgets/customTextNavigation.dart';
import 'package:aulataller/presentation/states/login/login_bloc.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => getIt<LoginBloc>(),
        child: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green[400],
              Colors.green[600],
              Colors.green[400],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(responsive.inchPercent(1)),
              child: Column(
                children: <Widget>[
                  const Logo(),
                  const LoginForm(),
                  SizedBox(height: responsive.heigthPercent(2)),
                  CustomTextNavigation(
                    text: 'Olvidaste tu contraseña?',
                    onTap: () {},
                  ),
                  SizedBox(height: responsive.heigthPercent(1)),
                  CustomTextNavigation(
                    text: 'Crear una cuenta nueva',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ),
                  SizedBox(height: responsive.heigthPercent(2.2)),
                  SocialMedia(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
