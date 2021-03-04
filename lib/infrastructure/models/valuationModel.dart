import 'package:aulataller/domain/entities/valuation.dart';
import 'package:flutter/foundation.dart' show required;

class ValuationModel extends Valuation {
  final String attendanceDay;
  final String typeOfService;
  final String inCharge;
  final int valuation;
  final String detail;
  final String id;

  ValuationModel({
    @required this.attendanceDay,
    @required this.typeOfService,
    @required this.inCharge,
    @required this.valuation,
    @required this.id,
    this.detail,
  });

  factory ValuationModel.fromMap(Map<String, dynamic> map) {
    return new ValuationModel(
      id: map["_id"],
      attendanceDay: map["idAsistencia"]["fecha"],
      inCharge: map["idAsistencia"]["idServicio"]["encargado"],
      typeOfService: map["idAsistencia"]["idServicio"]["idTipoServicio"]
          ["nombre"],
      valuation: map["valoracion"],
      detail: map["detalle"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "attendanceDay": this.attendanceDay,
      "inCharge": this.inCharge,
      "typeOfService": this.typeOfService,
      "valuation": this.valuation,
      "detail": this.detail,
    };
  }
}
