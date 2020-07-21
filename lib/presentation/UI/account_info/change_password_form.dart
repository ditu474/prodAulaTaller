import 'package:aulataller/presentation/UI/widgets/customInputForm.dart';
import 'package:aulataller/presentation/UI/widgets/gradientButton.dart';
import 'package:aulataller/presentation/states/account/account_bloc.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ChangePasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          CustomSnackBar.showLoadingSnackBar(
            ctx: context,
            leftWidget: Text('Validando...'),
          );
        }
        if (state.status.isSubmissionFailure) {
          CustomSnackBar.showErrorSnackBar(
            ctx: context,
            leftWidget: Text(state.error),
          );
        }
        if (state.status.isSubmissionSuccess) {
          CustomSnackBar.showSuccessSnackBar(
            ctx: context,
            leftWidget:
                Text('Se ha cambiado tu contraseña, ingresa nuevamente'),
          );
          context.bloc<AuthBloc>().add(AuthenticationLoggedOut());
        }
      },
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  responsive.inchPercent(3),
                ),
                color: Colors.green,
              ),
              child: CustomInputForm(
                hint: 'Contraseña actual',
                icon: Icons.enhanced_encryption,
                obscure: true,
                keyboard: TextInputType.text,
                errorMsg: state.currentPassword.value == ''
                    ? null
                    : state.currentPassword.valid
                        ? null
                        : 'Contraseña inválida',
                onChangeFunction: (value) {
                  context
                      .bloc<AccountBloc>()
                      .add(CurrentPasswordChanged(currentPassword: value));
                },
              ),
            ),
            SizedBox(height: responsive.heigthPercent(1)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  responsive.inchPercent(3),
                ),
                color: Colors.green,
              ),
              child: CustomInputForm(
                hint: 'Nueva contraseña',
                icon: Icons.enhanced_encryption,
                obscure: true,
                keyboard: TextInputType.text,
                errorMsg: state.newPassword.value == ''
                    ? null
                    : state.newPassword.valid ? null : 'Contraseña inválida',
                onChangeFunction: (value) {
                  context
                      .bloc<AccountBloc>()
                      .add(NewPasswordChanged(newPassword: value));
                },
              ),
            ),
            SizedBox(height: responsive.heigthPercent(1)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  responsive.inchPercent(3),
                ),
                color: Colors.green,
              ),
              child: CustomInputForm(
                hint: 'Confirmar nueva contraseña',
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
                      .bloc<AccountBloc>()
                      .add(PasswordConfirmChanged(passwordConfirm: value));
                },
              ),
            ),
            SizedBox(height: responsive.heigthPercent(2)),
            GradientButton(
              isEnabled: state.status.isValidated,
              inputText: 'Cambiar contraseña',
              buttonHandler: () {
                if (state.status.isValidated) {
                  context.bloc<AccountBloc>().add(ConfirmPasswordChange());
                }
              },
            ),
            SizedBox(height: responsive.heigthPercent(2)),
          ],
        );
      },
    );
  }
}
