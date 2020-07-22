import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/assists/assist_page.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/UI/widgets/gradientButton.dart';
import 'package:aulataller/presentation/states/assists/assists_bloc.dart';
import 'package:aulataller/presentation/states/valuations/valuations_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/data.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddValuationPage extends StatelessWidget {
  final String assistId;
  final ValuationsBloc bloc;

  const AddValuationPage(this.assistId, this.bloc);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Valoración'),
      ),
      body: BlocProvider<ValuationsBloc>(
        create: (ctx) => bloc,
        child: BlocConsumer<ValuationsBloc, ValuationsState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              CustomSnackBar.showErrorSnackBar(
                ctx: context,
                leftWidget: Text(state.error),
              );
            }
            if (state.status.isSubmissionInProgress) {
              CustomSnackBar.showLoadingSnackBar(
                ctx: context,
                leftWidget: Text('Creando Valoración...'),
              );
            }
            if (state.status.isSubmissionSuccess) {
              CustomSnackBar.showSuccessSnackBar(
                ctx: context,
                leftWidget: Text('Valoración creada!'),
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: DefaultBackground(
                child: Container(
                  padding: EdgeInsets.all(responsive.inchPercent(1)),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Gracias por utilizar nuestros servicios y valorarlos, esto nos ayuda a continuar mejorando cada día.',
                        style: TextStyle(
                          fontSize: responsive.inchPercent(2.5),
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Valorar (1 - Muy Insatisfecho, 10 - Muy Satisfecho)',
                            style: TextStyle(
                              fontSize: responsive.inchPercent(2.1),
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.inchPercent(0.5),
                            ),
                            margin: EdgeInsets.only(
                              top: responsive.heigthPercent(0.5),
                            ),
                            height: responsive.heigthPercent(5),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.green,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.green,
                                ),
                                value: state.assessment.value == 0
                                    ? null
                                    : state.assessment.value,
                                isExpanded: true,
                                style: TextStyle(
                                  fontSize: responsive.inchPercent(2.1),
                                  color: Colors.green,
                                ),
                                onChanged: (value) {
                                  context
                                      .bloc<ValuationsBloc>()
                                      .add(AssessmentChange(value));
                                },
                                isDense: true,
                                items: ITEMSONETOTEN,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsive.heigthPercent(2)),
                      TextField(
                        textAlign: TextAlign.start,
                        autocorrect: true,
                        onChanged: (value) {
                          context
                              .bloc<ValuationsBloc>()
                              .add(DetailChange(value));
                        },
                        keyboardType: TextInputType.text,
                        maxLength: 150,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          labelText: "Detalle",
                          hintText: "Escribe tú opinión",
                        ),
                      ),
                      SizedBox(height: responsive.heigthPercent(2)),
                      GradientButton(
                        isEnabled: state.status.isValidated,
                        inputText: 'Registrar asistencia',
                        buttonHandler: () {
                          if (state.status.isValidated) {
                            context
                                .bloc<ValuationsBloc>()
                                .add(AddValuation(this.assistId));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
