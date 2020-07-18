import 'package:aulataller/domain/entities/service.dart';
import 'package:aulataller/presentation/states/aula_abierta/aulaAbierta_bloc.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard(this.service);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: () {
        context.bloc<AulaAbiertaBloc>().add(ItemPressed(service.link));
      },
      child: Container(
        padding: EdgeInsets.all(responsive.inchPercent(1)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.orange,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 1),
              blurRadius: 3,
            ),
          ],
        ),
        width: responsive.widthPercent(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              service.assignment ?? service.theme,
              style: TextStyle(
                color: Colors.orange,
                fontSize: responsive.inchPercent(2),
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '${service.startTime} - ${service.endTime}',
              style: TextStyle(
                color: Colors.green,
                fontSize: responsive.inchPercent(1.6),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              service.teacher,
              style: TextStyle(
                color: Colors.black87,
                fontSize: responsive.inchPercent(1.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              service.campus.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: responsive.inchPercent(1.4),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
