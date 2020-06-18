import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.only(top:responsive.heigthPercent(4.5)),
      height: responsive.heigthPercent(22),
      child: Image.asset('assets/images/logo.png')
    );
  }
}