import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGButton extends StatelessWidget {
  final Function tapHandler;
  final double size;
  final String url;

  const SVGButton({
    Key key, 
    @required this.tapHandler, 
    this.size = 100, 
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child:SvgPicture.network(
            url,
            fit:BoxFit.contain,
            height: size,
            width: size)
        ),
      ),
    );
  }
}