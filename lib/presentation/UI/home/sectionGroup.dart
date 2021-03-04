import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SectionGroup extends StatelessWidget {
  final String tittle;
  final List<Widget> items;
  const SectionGroup({
    Key key,
    @required this.tittle,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IResponsive responsive = Responsive.of(context);
    return Column(
      children: <Widget>[
        Text(
          tittle,
          style: TextStyle(
            fontSize: responsive.inchPercent(4.5),
          ),
        ),
        Container(
          height: 2,
          width: double.infinity,
          color: Colors.black,
        ),
        SizedBox(height: responsive.heigthPercent(2)),
        StaggeredGridView.countBuilder(
          itemCount: items.length,
          primary: false,
          crossAxisCount: 3,
          itemBuilder: (ctx, i) => items[i],
          shrinkWrap: true,
          staggeredTileBuilder: (i) => StaggeredTile.fit(1),
        ),
      ],
    );
  }
}
