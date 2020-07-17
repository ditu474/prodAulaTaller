import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Section extends StatelessWidget {
  final String name;
  final String svg;
  final Function action;
  final Color colorLados;
  final Color colorMedio;

  const Section({
    Key key,
    @required this.name,
    @required this.svg,
    @required this.action,
    @required this.colorLados,
    @required this.colorMedio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: action,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(responsive.widthPercent(1)),
            height: responsive.heigthPercent(11),
            width: responsive.heigthPercent(11),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorLados, colorMedio, colorLados],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 1),
                  blurRadius: 5,
                ),
              ],
            ),
            child: SvgPicture.asset(
              svg,
              semanticsLabel: name,
              fit: BoxFit.contain,
              height: responsive.heigthPercent(8),
            ),
          ),
          SizedBox(height: responsive.heigthPercent(1)),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(height: 1),
          ),
        ],
      ),
    );
  }
}
