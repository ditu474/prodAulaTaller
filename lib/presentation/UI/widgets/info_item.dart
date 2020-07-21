import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({@required this.label, @required this.value});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: responsive.heigthPercent(1)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '$label:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.inchPercent(2.3),
                  height: 1,
                ),
              ),
              SizedBox(
                width: responsive.widthPercent(1),
              ),
              Flexible(
                child: Text(
                  value ?? 'No Aplica',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: responsive.inchPercent(2.15),
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
