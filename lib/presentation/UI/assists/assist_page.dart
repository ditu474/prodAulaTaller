import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/assists/assist_item.dart';
import 'package:aulataller/presentation/UI/widgets/customInputForm.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/UI/widgets/gradientButton.dart';
import 'package:aulataller/presentation/states/assists/assists_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AssistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssistsBloc>(
      create: (context) => getIt<AssistsBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Asistencias')),
        body: DefaultBackground(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Body(),
          ),
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
    return BlocConsumer<AssistsBloc, AssistsState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          CustomSnackBar.showErrorSnackBar(
            ctx: context,
            leftWidget: Text(state.error),
          );
        }
        if (state.status.isSubmissionInProgress) {
          CustomSnackBar.showLoadingSnackBar(
              ctx: context, leftWidget: Text('Creando asistencia...'));
        }
        if (state.status.isSubmissionSuccess) {
          CustomSnackBar.showSuccessSnackBar(
              ctx: context, leftWidget: Text('Asistencia creada'));
        }
      },
      builder: (context, state) {
        if (state.assists != null) {
          if (state.assists.length > 0) {
            final responsive = Responsive.of(context);
            return Container(
              margin: EdgeInsets.all(responsive.inchPercent(1)),
              child: Column(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(bottom: responsive.heigthPercent(1)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        responsive.inchPercent(3),
                      ),
                      color: Colors.green,
                    ),
                    child: CustomInputForm(
                      hint: 'Código',
                      icon: Icons.add,
                      obscure: false,
                      onChangeFunction: (value) {
                        context
                            .bloc<AssistsBloc>()
                            .add(CodeChanged(code: value));
                      },
                      keyboard: TextInputType.text,
                      errorMsg: state.code.value == ''
                          ? null
                          : state.code.valid ? null : 'Codigo inválido',
                    ),
                  ),
                  GradientButton(
                    isEnabled: state.status.isValidated,
                    inputText: 'Registrar asistencia',
                    buttonHandler: () {
                      if (state.status.isValidated) {
                        context
                            .bloc<AssistsBloc>()
                            .add(AddAssistButtonPressed());
                      }
                    },
                  ),
                  ListView.builder(
                    primary: false,
                    itemBuilder: (ctx, i) => AssistItem(
                      assist: state.assists[i],
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: state.assists.length,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('No Haz Registrado Ninguna Asistencia Aún'),
            );
          }
        }
        if (AssistsState() == state) {
          context.bloc<AssistsBloc>().add(GetAssists());
        }
        if (state.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox();
      },
    );
  }
}
