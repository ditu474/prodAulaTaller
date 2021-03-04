import 'package:flutter/material.dart';

class DefaultBackground extends StatelessWidget {
  final Widget child;

  const DefaultBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[200],
            Colors.grey[400],
            Colors.grey[200],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
