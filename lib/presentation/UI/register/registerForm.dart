import 'package:aulataller/presentation/UI/widgets/customDropDownButton.dart';
import 'package:aulataller/presentation/UI/widgets/customInputForm.dart';
import 'package:aulataller/presentation/UI/widgets/gradientButton.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:aulataller/presentation/states/register/register_bloc.dart';
import 'package:aulataller/utils/data.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          _showSnackBar(
            ctx: context,
            background: Colors.orange,
            leftWidget: Text('Verificando'),
            rightWidget: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else if (state.status.isSubmissionFailure) {
          _showSnackBar(
              ctx: context,
              background: Colors.red,
              leftWidget: Text(state.error),
              rightWidget: Icon(Icons.block));
        } else if (state.status.isSubmissionSuccess) {
          context.bloc<AuthBloc>().add(AuthenticationLoggedIn());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(
            responsive.inchPercent(2),
          ),
          child: Column(
            children: [
              CustomInputForm(
                hint: 'Nombre',
                icon: Icons.account_circle,
                obscure: false,
                keyboard: TextInputType.text,
                errorMsg: state.name.value == ''
                    ? null
                    : state.name.valid ? null : 'Nombre inválido',
                onChangeFunction: (value) {
                  context.bloc<RegisterBloc>().add(NameChanged(name: value));
                },
              ),
              SizedBox(height: responsive.heigthPercent(1.5)),
              CustomDropDownButton(
                value: state.typeOfDocument.value.isEmpty
                    ? null
                    : state.typeOfDocument.value,
                onChange: (value) {
                  context
                      .bloc<RegisterBloc>()
                      .add(TypeOfDocumentChanged(typeOfDocument: value));
                },
                tittle: 'Tipo de documento',
                items: ITEMSTYPEOFDOCUMENTS,
              ),
              SizedBox(height: responsive.heigthPercent(2.1)),
              CustomInputForm(
                hint: 'Documento',
                icon: Icons.account_circle,
                obscure: false,
                keyboard: state.typeOfDocument.value == "Pasaporte"
                    ? TextInputType.text
                    : TextInputType.number,
                errorMsg: state.document.value == ''
                    ? null
                    : state.document.valid ? null : 'Documento inválido',
                onChangeFunction: (value) {
                  context
                      .bloc<RegisterBloc>()
                      .add(DocumentChanged(document: value));
                },
              ),
              SizedBox(height: responsive.heigthPercent(1.5)),
              CustomDropDownButton(
                value: state.typeOfUser.value.isEmpty
                    ? null
                    : state.typeOfUser.value,
                onChange: (value) {
                  context
                      .bloc<RegisterBloc>()
                      .add(TypeOfUserChanged(typeOfUser: value));
                },
                tittle: 'Tipo de usuario',
                items: ITEMSROLES,
              ),
              SizedBox(height: responsive.heigthPercent(1.5)),
              state.typeOfUser.value == "docente" ||
                      state.typeOfUser.value == "estudiante"
                  ? Column(
                      children: <Widget>[
                        CustomDropDownButton(
                          value: state.campus.value.isEmpty
                              ? null
                              : state.campus.value,
                          onChange: (value) {
                            context
                                .bloc<RegisterBloc>()
                                .add(CampusChanged(campus: value));
                          },
                          tittle: 'Sede',
                          items: ITEMSCAMPUS,
                        ),
                        SizedBox(height: responsive.heigthPercent(1.5)),
                      ],
                    )
                  : SizedBox(),
              state.typeOfUser.value == "estudiante"
                  ? Column(
                      children: <Widget>[
                        CustomDropDownButton(
                          value: state.academicProgram.value.isEmpty
                              ? null
                              : state.academicProgram.value,
                          onChange: (value) {
                            context.bloc<RegisterBloc>().add(
                                AcademicProgramChanged(academicProgram: value));
                          },
                          tittle: 'Programa académico',
                          items: ITEMSACADEMICPROGRAM,
                        ),
                        SizedBox(height: responsive.heigthPercent(1.5)),
                        CustomDropDownButton(
                          value: state.semester.value == 0
                              ? null
                              : state.semester.value,
                          onChange: (value) {
                            context
                                .bloc<RegisterBloc>()
                                .add(SemesterChanged(semester: value));
                          },
                          tittle: 'Semestre académico',
                          items: ITEMSONETOTEN,
                        ),
                        SizedBox(height: responsive.heigthPercent(2.1)),
                      ],
                    )
                  : SizedBox(),
              CustomInputForm(
                hint: 'Email',
                icon: Icons.email,
                obscure: false,
                keyboard: TextInputType.emailAddress,
                errorMsg: state.email.value == ''
                    ? null
                    : state.email.valid ? null : 'Email inválido',
                onChangeFunction: (value) {
                  context.bloc<RegisterBloc>().add(EmailChanged(email: value));
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
                    : state.password.valid ? null : 'Contraseña insegura',
                onChangeFunction: (value) {
                  context
                      .bloc<RegisterBloc>()
                      .add(PasswordChanged(password: value));
                },
              ),
              state.password.invalid
                  ? Text(
                      'La contraseña debe tener 8 caracteres, 1 letra mayúscula, 1 minúscula y 1 número.',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: responsive.heigthPercent(2.1)),
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
                      .bloc<RegisterBloc>()
                      .add(PasswordConfirmChanged(passwordConfirm: value));
                },
              ),
              SizedBox(height: responsive.heigthPercent(3)),
              GradientButton(
                inputText: 'Registrarme',
                buttonHandler: () {
                  if (!state.status.isSubmissionInProgress &&
                      state.status.isValidated) {
                    context.bloc<RegisterBloc>().add(RegisterUserConfirmed());
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

void _showSnackBar({
  @required BuildContext ctx,
  @required Color background,
  @required Widget leftWidget,
  @required Widget rightWidget,
}) {
  Scaffold.of(ctx)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[leftWidget, rightWidget],
      ),
      backgroundColor: background,
    ));
}
