import 'package:aulataller/presentation/UI/widgets/section.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Column(
      children: <Widget>[
        Text(
          "Servicios Aula Taller",
          style: TextStyle(
            fontSize: responsive.inchPercent(4.5),
          ),
        ),
        Container(
          height: 2,
          width: double.infinity,
          color: Colors.black,
        ),
        SizedBox(height: responsive.heigthPercent(2)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Section(
                  action: () {},
                  svg: "assets/icons/aula_abierta.svg",
                  name: 'Aula\nAbierta',
                  colorLados: Colors.green[200],
                  colorMedio: Colors.green[500],
                ),
                SizedBox(height: responsive.heigthPercent(1)),
                Section(
                  action: () {},
                  svg: "assets/icons/aula_abierta.svg",
                  name: 'Cuadro De\n Mando',
                  colorLados: Colors.green[200],
                  colorMedio: Colors.green[500],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Section(
                  action: () {},
                  svg: "assets/icons/sabios_al_gratin.svg",
                  name: 'Sabios Al\nGratín',
                  colorLados: Colors.orange[200],
                  colorMedio: Colors.orange[500],
                ),
                SizedBox(height: responsive.heigthPercent(1)),
                Section(
                  action: () {},
                  svg: "assets/icons/sabios_al_gratin.svg",
                  name: 'Formulario\nDe Contacto',
                  colorLados: Colors.orange[200],
                  colorMedio: Colors.orange[500],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Section(
                  action: () {},
                  svg: "assets/icons/psicopedagogico.svg",
                  name: 'Acompañamiento\nPsicopedaógico',
                  colorLados: Colors.blue[200],
                  colorMedio: Colors.blue[500],
                ),
                SizedBox(height: responsive.heigthPercent(1)),
                Section(
                  action: () {},
                  svg: "assets/icons/psicopedagogico.svg",
                  name: 'Ver Todos\nLos Servicios',
                  colorLados: Colors.blue[200],
                  colorMedio: Colors.blue[500],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
