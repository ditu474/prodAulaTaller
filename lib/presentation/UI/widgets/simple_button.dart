import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final Function handler;
  final String text;
  const SimpleButton({
    Key key,
    @required this.handler,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: handler,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: responsive.heigthPercent(3),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: responsive.inchPercent(2.2),
              ),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
