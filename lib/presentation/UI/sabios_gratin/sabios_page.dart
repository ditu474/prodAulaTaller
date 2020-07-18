import 'package:aulataller/injection_container.dart';
import 'package:aulataller/presentation/UI/widgets/defaultBackground.dart';
import 'package:aulataller/presentation/UI/widgets/simple_button.dart';
import 'package:aulataller/presentation/states/sabios_gratin/sabios_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SabiosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sabios Al Gratín'),
      ),
      body: BlocProvider<SabiosBloc>(
        create: (context) => getIt<SabiosBloc>(),
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
    return BlocConsumer<SabiosBloc, SabiosState>(
      listener: (context, state) {
        if (state is SabiosLoading) {
          CustomSnackBar.showLoadingSnackBar(
            ctx: context,
            leftWidget: Text('Redirigiendo...'),
          );
        }
        if (state is SabiosFailure) {
          CustomSnackBar.showErrorSnackBar(
            ctx: context,
            leftWidget: Text(state.errorMsg),
          );
        }
      },
      builder: (context, state) {
        return DefaultBackground(
          child: Padding(
            padding: EdgeInsets.only(
              left: responsive.widthPercent(5),
              right: responsive.widthPercent(5),
              top: responsive.heigthPercent(2),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Las sesiones de Sabios al Gratín se reanudarán el proximo semestre 2020-2, el equipo Aula Taller de Ciencias comienza a desarrollar una programación de temáticas y diseño de propuestas para la formación de la comunidad docente. Estaremos informando la reanudación de esta actividad institucional.',
                  style: TextStyle(
                    fontSize: responsive.inchPercent(2.5),
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
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
                          context
                              .bloc<SabiosBloc>()
                              .add(CurrentSessionPressed());
                        },
                        text: 'Google Meet De Las Sesiones',
                      ),
                      SimpleButton(
                        handler: () {
                          context.bloc<SabiosBloc>().add(RepositoryPressed());
                        },
                        text: 'Sesiones Anteriores',
                      ),
                      SimpleButton(
                        handler: () {
                          context.bloc<SabiosBloc>().add(FormPressed());
                        },
                        text: 'Valorar El Servicio De 2020-1',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
