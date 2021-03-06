import 'package:aulataller/presentation/UI/widgets/customInputForm.dart';
import 'package:aulataller/presentation/UI/widgets/gradientButton.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:aulataller/presentation/states/login/login_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          CustomSnackBar.showLoadingSnackBar(
            ctx: context,
            leftWidget: Text('Verificando'),
          );
        } else if (state.status.isSubmissionFailure) {
          CustomSnackBar.showErrorSnackBar(
            ctx: context,
            leftWidget: Text(state.error),
          );
        } else if (state.status.isSubmissionSuccess) {
          context.bloc<AuthBloc>().add(AuthenticationLoggedIn());
        }
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: responsive.heigthPercent(2.3)),
          padding: EdgeInsets.only(
            top: responsive.heigthPercent(4),
            right: responsive.widthPercent(5),
            left: responsive.widthPercent(5),
          ),
          child: Column(
            children: [
              CustomInputForm(
                hint: 'Email',
                icon: Icons.email,
                obscure: false,
                keyboard: TextInputType.emailAddress,
                errorMsg: state.email.value == ''
                    ? null
                    : state.email.valid ? null : 'Email inválido',
                onChangeFunction: (value) {
                  context.bloc<LoginBloc>().add(EmailChanged(email: value));
                },
              ),
              SizedBox(height: responsive.heigthPercent(2.1)),
              CustomInputForm(
                hint: 'Contraseña',
                icon: Icons.enhanced_encryption,
                obscure: true,
                keyboard: TextInputType.text,
                errorMsg: state.password.value == ''
                    ? null
                    : state.password.valid ? null : 'Contraseña inválida',
                onChangeFunction: (value) {
                  context
                      .bloc<LoginBloc>()
                      .add(PasswordChanged(password: value));
                },
              ),
              SizedBox(height: responsive.heigthPercent(5)),
              GradientButton(
                isEnabled: state.status.isValidated,
                inputText: 'Ingresar',
                buttonHandler: () {
                  if (state.status.isValidated) {
                    context
                        .bloc<LoginBloc>()
                        .add(LoginWithCredentialsButtonPressed());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
