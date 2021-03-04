import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final String name;
  final List<String> privacy;

  const ServiceItem({@required this.name, @required this.privacy});

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: responsive.heigthPercent(1)),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-1.0, -4.0),
              end: Alignment(1.0, 4.0),
              colors: [
                Colors.grey[200],
                Colors.grey[300],
              ]),
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
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: responsive.inchPercent(2.5),
          height: 1,
        ),
      ),
    );
  }
}
