import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class TopBackArrow extends StatelessWidget {
  const TopBackArrow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Container(
      padding: EdgeInsets.only(
        left: responsive.widthPercent(5),
      ),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          size: responsive.inchPercent(3.3),
        ),
      ),
    );
  }
}
