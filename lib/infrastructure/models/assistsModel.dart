import 'package:aulataller/domain/entities/assist.dart';
import 'package:flutter/foundation.dart' show required;

class AssistModel extends Assist {
  final bool valued;
  final String date;
  final String typeOfService;
  final String inCharge;
  final String id;

  AssistModel({
    @required this.valued,
    @required this.date,
    @required this.typeOfService,
    @required this.inCharge,
    @required this.id,
  });

  factory AssistModel.fromMap(Map<String, dynamic> map) {
    return new AssistModel(
        id: map["_id"],
        valued: map["valorado"],
        date: map["fecha"],
        typeOfService: map["idServicio"]["idTipoServicio"]["nombre"],
        inCharge: map["idServicio"]["encargado"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "valued": this.valued,
      "date": this.date,
      "typeOfService": this.typeOfService,
      "inCharge": this.inCharge,
    };
  }
}
