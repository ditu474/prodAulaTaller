import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:aulataller/presentation/states/aula_abierta/aulaAbierta_bloc.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceCard extends StatelessWidget {
  final AulaAbiertaService service;

  const ServiceCard(this.service);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: () {
        context.bloc<AulaAbiertaBloc>().add(ItemPressed(service.link));
      },
      child: Container(
        margin: EdgeInsets.all(responsive.inchPercent(1)),
        padding: EdgeInsets.all(responsive.inchPercent(1)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.orange,
            style: BorderStyle.solid,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 1),
              blurRadius: 3,
            ),
          ],
        ),
        width: responsive.widthPercent(42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextLine(
              weight: FontWeight.w700,
              color: Colors.orange,
              text: service.assignment ?? service.theme,
              size: responsive.inchPercent(2.3),
            ),
            TextLine(
              weight: FontWeight.w600,
              color: Colors.green,
              text: '${service.startTime} - ${service.endTime}',
              size: responsive.inchPercent(2.2),
            ),
            TextLine(
              weight: FontWeight.w500,
              color: Colors.black,
              text: service.teacher,
              size: responsive.inchPercent(2),
            ),
            TextLine(
              weight: FontWeight.w400,
              color: Colors.grey,
              text: service.campus.toUpperCase(),
              size: responsive.inchPercent(1.6),
            ),
          ],
        ),
      ),
    );
  }
}

class TextLine extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;

  const TextLine(
      {@required this.text,
      @required this.color,
      @required this.size,
      @required this.weight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
          height: 1,
        ),
      ),
    );
  }
}
