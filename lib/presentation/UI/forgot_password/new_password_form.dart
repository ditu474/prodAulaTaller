import 'package:aulataller/presentation/states/forgot_password/forgot_pass_bloc.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:formz/formz.dart';
import 'package:aulataller/presentation/UI/widgets/customInputForm.dart';
import 'package:aulataller/presentation/UI/widgets/customTextNavigation.dart';
import 'package:aulataller/presentation/UI/widgets/gradientButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordForm extends StatelessWidget {
  const NewPasswordForm({
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
              ctx: context, leftWidget: Text('Cambiando contraseña...'));
        }
        if (state.status.isSubmissionSuccess) {
          CustomSnackBar.showSuccessSnackBar(
              ctx: context, leftWidget: Text('Tu contraseña se ha modificado'));
          context.bloc<ForgotPassBloc>().add(ChangeForm());
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: responsive.heigthPercent(2)),
            CustomInputForm(
              hint: 'Código',
              icon: Icons.blur_circular,
              obscure: false,
              keyboard: TextInputType.text,
              errorMsg: state.code.value == ''
                  ? null
                  : state.code.valid ? null : 'Codigo inválido',
              onChangeFunction: (value) {
                context.bloc<ForgotPassBloc>().add(TokenChanged(value));
              },
            ),
            SizedBox(height: responsive.heigthPercent(2)),
            CustomInputForm(
              hint: 'Nueva Contraseña',
              icon: Icons.enhanced_encryption,
              obscure: true,
              keyboard: TextInputType.text,
              errorMsg: state.newPassword.value == ''
                  ? null
                  : state.newPassword.valid ? null : 'Contraseña inválida',
              onChangeFunction: (value) {
                context.bloc<ForgotPassBloc>().add(NewPasswordChanged(value));
              },
            ),
            SizedBox(height: responsive.heigthPercent(2)),
            CustomInputForm(
              hint: 'Confirmar contraseña',
              icon: Icons.enhanced_encryption,
              obscure: true,
              keyboard: TextInputType.text,
              errorMsg: state.confirmPassword.value == ''
                  ? null
                  : state.confirmPassword.valid
                      ? null
                      : 'Las contraseñas no coinciden',
              onChangeFunction: (value) {
                context
                    .bloc<ForgotPassBloc>()
                    .add(ConfirmPasswordChanged(value));
              },
            ),
            SizedBox(height: responsive.heigthPercent(2)),
            GradientButton(
              isEnabled: state.status.isValidated,
              inputText: 'Cambiar Contraseña',
              buttonHandler: () {
                if (state.status.isValidated) {
                  context
                      .bloc<ForgotPassBloc>()
                      .add(ChangePasswordButtonPressed());
                }
              },
            ),
            SizedBox(height: responsive.heigthPercent(2)),
            CustomTextNavigation(
              text: 'No tengo un código aún',
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
