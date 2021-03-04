import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class ValuationStars extends StatelessWidget {
  final int quantity;

  ValuationStars(this.quantity);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return ListView.builder(
      itemCount: quantity,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, i) => Icon(
        Icons.star,
        size: responsive.heigthPercent(3),
      ),
      shrinkWrap: true,
    );
  }
}
