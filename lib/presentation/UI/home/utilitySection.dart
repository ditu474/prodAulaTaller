import 'package:aulataller/presentation/UI/home/sectionGroup.dart';
import 'package:aulataller/presentation/UI/widgets/section.dart';
import 'package:aulataller/presentation/states/authentication/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UtilitySection extends StatelessWidget {
  UtilitySection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Section> sectionsItems = [
      Section(
        action: () {},
        svg: "assets/icons/accountInfo.svg",
        name: 'Información De La Cuenta',
        colorLados: Colors.cyan[200],
        colorMedio: Colors.cyan[500],
      ),
      Section(
        action: () {},
        svg: "assets/icons/asistence.svg",
        name: 'Mis Asistencias',
        colorLados: Colors.deepPurple[200],
        colorMedio: Colors.deepPurple[500],
      ),
      Section(
        action: () {},
        svg: "assets/icons/valoration.svg",
        name: 'Mis Valoraciones',
        colorLados: Colors.indigo[200],
        colorMedio: Colors.indigo[500],
      ),
      Section(
        action: () {
          context.bloc<AuthBloc>().add(AuthenticationLoggedOut());
        },
        svg: "assets/icons/log-out.svg",
        name: 'Salir',
        colorLados: Colors.red[200],
        colorMedio: Colors.red[500],
      ),
    ];

    return Column(
      children: <Widget>[
        SectionGroup(
          tittle: 'Utilidades',
          items: sectionsItems,
        ),
      ],
    );
  }
}
