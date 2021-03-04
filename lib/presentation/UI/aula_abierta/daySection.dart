import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/presentation/UI/aula_abierta/ServiceCard.dart';
import 'package:aulataller/presentation/UI/widgets/headerText.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class DaySection extends StatelessWidget {
  final List<AulaAbiertaService> services;
  final String day;
  const DaySection({
    Key key,
    @required this.services,
    @required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Column(
      children: <Widget>[
        HeaderText(
          text: day,
        ),
        Container(
          height: responsive.heigthPercent(29),
          width: double.infinity,
          child: ListView.builder(
            itemBuilder: (_, index) => FittedBox(
              fit: BoxFit.none,
              child: ServiceCard(services[index]),
            ),
            itemCount: services.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
