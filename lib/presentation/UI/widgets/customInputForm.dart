import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomInputForm extends StatelessWidget {
  final bool obscure;
  final IconData icon;
  final String hint;
  final Function onChangeFunction;
  final TextInputType keyboard;
  final String errorMsg;

  const CustomInputForm({
    Key key,
    @required this.obscure,
    @required this.icon,
    @required this.hint,
    @required this.onChangeFunction,
    @required this.keyboard,
    this.errorMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Container(
      decoration: BoxDecoration(
          color: Color(0XFFFFFF).withOpacity(0.3),
          borderRadius: BorderRadius.circular(responsive.inchPercent(3))),
      child: TextFormField(
        keyboardType: keyboard,
        obscureText: obscure,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: responsive.inchPercent(2)),
        decoration: InputDecoration(
          errorText: errorMsg,
          suffixIcon: Icon(icon, color: Colors.white),
          errorStyle: TextStyle(height: 1),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: responsive.inchPercent(1.9),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onChanged: onChangeFunction,
      ),
    );
  }
}
