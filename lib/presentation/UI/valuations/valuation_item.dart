import 'package:aulataller/domain/entities/valuation.dart';
import 'package:aulataller/presentation/UI/valuations/valuation_stars.dart';
import 'package:aulataller/presentation/UI/widgets/info_item.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class ValuationItem extends StatelessWidget {
  final Valuation valuation;

  const ValuationItem(this.valuation);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: responsive.heigthPercent(0.8),
        horizontal: responsive.widthPercent(2),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, -4.0),
            end: Alignment(1.0, 4.0),
            colors: [
              Colors.grey[200],
              Colors.grey[300],
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[500],
                offset: Offset(3.0, 3.0),
                blurRadius: 8.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Colors.grey[300],
                offset: Offset(-3.0, -3.0),
                blurRadius: 8.0,
                spreadRadius: 1.0),
          ]),
      padding: EdgeInsets.all(responsive.inchPercent(1)),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          InfoItem(
            label: 'Fecha de asistencia',
            value: valuation.attendanceDay.split('T')[0],
          ),
          InfoItem(
            label: 'Tipo de  servicio',
            value: valuation.typeOfService,
          ),
          InfoItem(
            label: 'Encargado',
            value: valuation.inCharge,
          ),
          InfoItem(
            label: 'Detalle',
            value: valuation.detail == null
                ? 'No Aplica'
                : valuation.detail.trim().length == 0
                    ? 'No Aplica'
                    : valuation.detail.trim(),
          ),
          Container(
            height: responsive.heigthPercent(3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Valoración:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.inchPercent(2.3),
                    height: 1,
                  ),
                ),
                SizedBox(width: responsive.widthPercent(1)),
                Flexible(child: ValuationStars(valuation.valuation))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
