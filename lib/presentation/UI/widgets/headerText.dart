import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: responsive.widthPercent(5),
        top: responsive.heigthPercent(2),
      ),
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: responsive.inchPercent(5),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
          color: Colors.black,
        ),
      ),
    );
  }
}
