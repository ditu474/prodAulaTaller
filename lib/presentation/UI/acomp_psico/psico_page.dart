import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/widgets/simple_button.dart';
import 'package:aulataller/presentation/states/acomp_psico/psico_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PsicoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('Acompañamiento Psicopedagógico')),
      ),
      body: BlocProvider<PsicoBloc>(
        create: (context) => getIt<PsicoBloc>(),
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
    return BlocConsumer<PsicoBloc, PsicoState>(
      listener: (context, state) {
        if (state is PsicoLoading) {
          CustomSnackBar.showLoadingSnackBar(
            ctx: context,
            leftWidget: Text('Abriendo WhatsApp...'),
          );
        }
        if (state is PsicoFailure) {
          CustomSnackBar.showErrorSnackBar(
            ctx: context,
            leftWidget: Text(state.errorMsg),
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.widthPercent(5),
            vertical: responsive.heigthPercent(2),
          ),
          width: responsive.widthPercent(100),
          height: responsive.heigthPercent(100),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[300],
                Colors.grey[400],
                Colors.grey[300],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: <Widget>[
              Text(
                'El servicio de acompañamiento psicopedagógico está enfocado únicamente para los estudiantes del Politécnico Jaime Isaza Cadavid y se presta de lunes a viernes de 2PM a 4PM. Si estás interesado en este servicio, reserva una cita presionando los números que se encuentran debajo y se te redirigirá a un chat de Whatsapp.',
                style: TextStyle(
                  fontSize: responsive.inchPercent(2.5),
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: responsive.heigthPercent(2)),
                child: Text(
                  '¿Quieres Reservar?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.inchPercent(4),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: responsive.heigthPercent(2)),
                padding: EdgeInsets.only(
                  left: responsive.widthPercent(5),
                  right: responsive.widthPercent(5),
                  bottom: responsive.heigthPercent(2),
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SimpleButton(
                      handler: () {
                        context.bloc<PsicoBloc>().add(ClaudiaButtonPressed());
                      },
                      text: 'Claudia Garcia (3106923537)',
                    ),
                    SimpleButton(
                      handler: () {
                        context.bloc<PsicoBloc>().add(YennyButtonPressed());
                      },
                      text: 'Yenny Rodriguez (3106923502)',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
