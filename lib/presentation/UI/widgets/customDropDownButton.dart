import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    Key key,
    @required this.value,
    @required this.tittle,
    @required this.onChange,
    @required this.items,
  }) : super(key: key);

  final dynamic value;
  final String tittle;
  final Function onChange;
  final List<DropdownMenuItem<dynamic>> items;

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tittle,
          style: TextStyle(
            fontSize: responsive.inchPercent(2),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: EdgeInsets.all(
            responsive.inchPercent(0.5),
          ),
          margin: EdgeInsets.only(
            top: responsive.heigthPercent(0.5),
          ),
          height: responsive.heigthPercent(5),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
          child: DropdownButton(
            icon: Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.white,
            ),
            value: value,
            isExpanded: true,
            dropdownColor: Colors.green[300],
            style: TextStyle(
              fontSize: responsive.inchPercent(1.9),
              color: Colors.white,
            ),
            onChanged: onChange,
            isDense: true,
            items: items,
          ),
        ),
      ],
    );
  }
}
