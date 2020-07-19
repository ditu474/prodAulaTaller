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
            margin: EdgeInsets.only(top: responsive.heigthPercent(1)),
            padding: EdgeInsets.all(responsive.inchPercent(0.5)),
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
              height: responsive.heigthPercent(9),
            ),
          ),
          SizedBox(height: responsive.heigthPercent(1.5)),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w700,
              fontSize: responsive.heigthPercent(1.8),
            ),
          ),
        ],
      ),
    );
  }
}
