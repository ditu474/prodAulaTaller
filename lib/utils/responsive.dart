import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart' show required;
import 'dart:math' as math;


abstract class IResponsive {
  double widthPercent(double percent);

  double heigthPercent(double percent);

  double inchPercent(double percent);
}

class Responsive implements IResponsive{
  final double height, width, inch;

  Responsive._({@required this.height, 
  @required this.width, 
  @required this.inch});

  static Responsive of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive._(height: size.height, width: size.width, inch: inch);
  }

  @override
  double heigthPercent(double percent) {
    return this.height * percent / 100;
  }
  
  @override
  double inchPercent(double percent) {
    return this.inch * percent / 100;
  }

  @override
  double widthPercent(double percent) {
    return this.width * percent / 100;
  }
}
