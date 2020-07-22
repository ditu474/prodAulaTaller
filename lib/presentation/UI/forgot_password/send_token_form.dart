import 'package:aulataller/presentation/states/forgot_password/forgot_pass_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:aulataller/presentation/UI/widgets/customInputForm.dart';
import 'package:aulataller/presentation/UI/widgets/customTextNavigation.dart';
import 'package:aulataller/presentation/UI/widgets/gradientButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SendTokenForm extends StatelessWidget {
  const SendTokenForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return BlocConsumer<ForgotPassBloc, ForgotPassState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          CustomSnackBar.showErrorSnackBar(
            ctx: context,
            leftWidget: Text(state.error),
          );
        }
        if (state.status.isSubmissionInProgress) {
          CustomSnackBar.showLoadingSnackBar(
              ctx: context, leftWidget: Text('Enviando email...'));
        }
        if (state.status.isSubmissionSuccess) {
          CustomSnackBar.showSuccessSnackBar(
              ctx: context, leftWidget: Text('Email enviado'));
          context.bloc<ForgotPassBloc>().add(ChangeForm());
        }
      },
      builder: (context, state) {
        return Column(
          children: <Widget>[
            SizedBox(height: responsive.heigthPercent(2)),
            CustomInputForm(
              hint: 'Email',
              icon: Icons.email,
              obscure: false,
              keyboard: TextInputType.emailAddress,
              errorMsg: state.email.value == ''
                  ? null
                  : state.email.valid ? null : 'Email inválido',
              onChangeFunction: (value) {
                context.bloc<ForgotPassBloc>().add(EmailChanged(value));
              },
            ),
            SizedBox(height: responsive.heigthPercent(2)),
            GradientButton(
              isEnabled: state.status.isValidated,
              inputText: 'Enviar Código',
              buttonHandler: () {
                if (state.status.isValidated) {
                  context.bloc<ForgotPassBloc>().add(SendEmailButtonPressed());
                }
              },
            ),
            SizedBox(height: responsive.heigthPercent(2)),
            CustomTextNavigation(
              text: 'Ya tengo un código',
              onTap: () {
                context.bloc<ForgotPassBloc>().add(ChangeForm());
              },
            ),
          ],
        );
      },
    );
  }
}
