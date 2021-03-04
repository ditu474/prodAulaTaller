import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/forgot_password/new_password_form.dart';
import 'package:aulataller/presentation/UI/forgot_password/send_token_form.dart';
import 'package:aulataller/presentation/states/forgot_password/forgot_pass_bloc.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('Restaurar Contraseña')),
      ),
      body: Container(
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
        padding: EdgeInsets.all(responsive.inchPercent(1)),
        child: BlocProvider<ForgotPassBloc>(
          create: (ctx) => getIt<ForgotPassBloc>(),
          child: SingleChildScrollView(child: Body()),
        ),
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
    return BlocBuilder<ForgotPassBloc, ForgotPassState>(
      builder: (context, state) {
        if (state.alreadyHaveToken) {
          return NewPasswordForm();
        } else {
          return SendTokenForm();
        }
      },
    );
  }
}
