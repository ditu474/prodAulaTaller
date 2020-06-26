import 'package:aulataller/presentation/UI/register/registerForm.dart';
import 'package:aulataller/presentation/UI/widgets/TopBackArrow.dart';
import 'package:aulataller/presentation/UI/widgets/headerText.dart';
import 'package:aulataller/presentation/states/register/register_bloc.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aulataller/injection_container.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        create: (context) => getIt<RegisterBloc>(),
        child: Body(),
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
                  TopBackArrow(),
                  HeaderText(
                    text: 'Registro',
                  ),
                  RegisterForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
