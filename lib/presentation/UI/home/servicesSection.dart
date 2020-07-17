import 'package:aulataller/presentation/UI/home/sectionGroup.dart';
import 'package:aulataller/presentation/UI/widgets/section.dart';
import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  ServicesSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionGroup(
      tittle: 'Servicios Aula Taller',
      items: sectionsItems,
    );
  }

  final List<Section> sectionsItems = [
    Section(
      action: () {},
      svg: "assets/icons/aula_abierta.svg",
      name: 'Aula\nAbierta',
      colorLados: Colors.green[200],
      colorMedio: Colors.green[500],
    ),
    Section(
      action: () {},
      svg: "assets/icons/sabios_al_gratin.svg",
      name: 'Sabios Al\nGratín',
      colorLados: Colors.orange[200],
      colorMedio: Colors.orange[500],
    ),
    Section(
      action: () {},
      svg: "assets/icons/psicopedagogico.svg",
      name: 'Acompañamiento\nPsicopedagógico',
      colorLados: Colors.blue[200],
      colorMedio: Colors.blue[500],
    ),
    Section(
      action: () {},
      svg: "assets/icons/analytics.svg",
      name: 'Cuadro De\nMando',
      colorLados: Colors.yellow[200],
      colorMedio: Colors.yellow[500],
    ),
    Section(
      action: () {},
      svg: "assets/icons/form.svg",
      name: 'Formulario\nDe Contacto',
      colorLados: Colors.amber[200],
      colorMedio: Colors.amber[500],
    ),
    Section(
      action: () {},
      svg: "assets/icons/search.svg",
      name: 'Ver Todos\nLos Servicios',
      colorLados: Colors.brown[200],
      colorMedio: Colors.brown[500],
    ),
  ];
}
