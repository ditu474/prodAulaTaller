import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomTextNavigation extends StatelessWidget {
  final String text;
  final Function onTap;

  const CustomTextNavigation({
    Key key, 
    @required this.text, 
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(responsive.inchPercent(0.6)),
        child: Text(
          text,
          style:TextStyle(
            fontSize: responsive.inchPercent(1.72),
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1
          )
        ),
      )
    );
  }
}