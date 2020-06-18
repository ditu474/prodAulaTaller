import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Function buttonHandler;
  final String inputText;

  const GradientButton({
    Key key,
    @required this.buttonHandler,
    @required this.inputText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return RaisedButton(
      onPressed:buttonHandler,
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(responsive.inchPercent(3))
        ),
      elevation: 8,
      textColor: Colors.white,
      color: Colors.transparent,
      padding: const EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.all(responsive.inchPercent(1)),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(responsive.inchPercent(3)),
          gradient: LinearGradient(
            colors:[
              Colors.orange[600],
              Colors.orange[400],
              Colors.orange[200]
            ]
          )
        ),
        child:Center(
          child:Text(
            inputText,
            style:TextStyle(
              fontSize: responsive.inchPercent(2.4),
              fontWeight: FontWeight.bold
            )
          )
        )
      )
    );
  }
}