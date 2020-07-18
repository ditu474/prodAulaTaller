import 'package:aulataller/presentation/UI/acomp_psico/psico_page.dart';
import 'package:aulataller/presentation/UI/all_services/allServices_page.dart';
import 'package:aulataller/presentation/UI/aula_abierta/aulaAbierta_page.dart';
import 'package:aulataller/presentation/UI/home/sectionGroup.dart';
import 'package:aulataller/presentation/UI/sabios_gratin/sabios_page.dart';
import 'package:aulataller/presentation/UI/widgets/section.dart';
import 'package:aulataller/presentation/states/home/home_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesSection extends StatelessWidget {
  ServicesSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoading) {
          CustomSnackBar.showLoadingSnackBar(
            ctx: context,
            leftWidget: Text('Redirigiendo...'),
          );
        }
        if (state is HomeFailure) {
          CustomSnackBar.showErrorSnackBar(
            ctx: context,
            leftWidget: Text(state.errorMsg),
          );
        }
      },
      builder: (context, state) {
        final List<Section> sectionsItems = [
          Section(
            action: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AulaAbiertaPage()),
              );
            },
            svg: "assets/icons/aula_abierta.svg",
            name: 'Aula Abierta',
            colorLados: Colors.green[200],
            colorMedio: Colors.green[500],
          ),
          Section(
            action: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SabiosPage()),
              );
            },
            svg: "assets/icons/sabios_al_gratin.svg",
            name: 'Sabios Al Gratín',
            colorLados: Colors.orange[200],
            colorMedio: Colors.orange[500],
          ),
          Section(
            action: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PsicoPage()),
              );
            },
            svg: "assets/icons/psicopedagogico.svg",
            name: 'Acompañamiento Psicopedagógico',
            colorLados: Colors.blue[200],
            colorMedio: Colors.blue[500],
          ),
          Section(
            action: () {
              context.bloc<HomeBloc>().add(CuadroDeMandoPressed());
            },
            svg: "assets/icons/analytics.svg",
            name: 'Cuadro De Mando',
            colorLados: Colors.yellow[200],
            colorMedio: Colors.yellow[500],
          ),
          Section(
            action: () {
              context.bloc<HomeBloc>().add(RequestsFormPressed());
            },
            svg: "assets/icons/form.svg",
            name: 'Formulario De Solicitudes',
            colorLados: Colors.amber[200],
            colorMedio: Colors.amber[500],
          ),
          Section(
            action: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllServicesPage()),
              );
            },
            svg: "assets/icons/search.svg",
            name: 'Ver Todos Los Servicios',
            colorLados: Colors.brown[200],
            colorMedio: Colors.brown[500],
          ),
        ];
        return SectionGroup(
          tittle: 'Servicios Aula Taller',
          items: sectionsItems,
        );
      },
    );
  }
}
