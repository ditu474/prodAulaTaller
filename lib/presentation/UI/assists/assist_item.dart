import 'package:aulataller/domain/entities/assist.dart';
import 'package:aulataller/presentation/UI/valuations/add_valuation_page.dart';
import 'package:aulataller/presentation/UI/widgets/info_item.dart';
import 'package:aulataller/presentation/states/valuations/valuations_bloc.dart';
import 'package:aulataller/utils/customSnackBar.dart';
import 'package:aulataller/utils/responsive.dart';
import 'package:flutter/material.dart';

class AssistItem extends StatelessWidget {
  final Assist assist;
  final ValuationsBloc bloc;

  const AssistItem({
    Key key,
    @required this.assist,
    @required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return GestureDetector(
      onTap: () {
        if (assist.valued) {
          CustomSnackBar.showErrorSnackBar(
              ctx: context,
              leftWidget: Text('Ya haz valorado esta asistencia'));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddValuationPage(assist.id, bloc),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.all(responsive.inchPercent(0.5)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, -4.0),
              end: Alignment(1.0, 4.0),
              colors: [
                Colors.grey[200],
                Colors.grey[300],
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(3.0, 3.0),
                  blurRadius: 8.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-3.0, -3.0),
                  blurRadius: 8.0,
                  spreadRadius: 1.0),
            ]),
        padding: EdgeInsets.all(responsive.inchPercent(1)),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                children: <Widget>[
                  InfoItem(
                    label: 'Fecha',
                    value: assist.date.split('T')[0],
                  ),
                  InfoItem(
                    label: 'Tipo de  servicio',
                    value: assist.typeOfService,
                  ),
                  InfoItem(
                    label: 'Encargado',
                    value: assist.inCharge,
                  ),
                ],
              ),
            ),
            Icon(assist.valued
                ? Icons.check_box
                : Icons.check_box_outline_blank),
          ],
        ),
      ),
    );
  }
}
