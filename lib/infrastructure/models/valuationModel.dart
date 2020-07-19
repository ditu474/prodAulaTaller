import 'package:aulataller/domain/entities/valuation.dart';
import 'package:flutter/foundation.dart' show required;

class ValuationModel extends Valuation {
  final String attendanceDay;
  final String typeOfService;
  final String inCharge;
  final int valuation;
  final String detail;

  ValuationModel({
    @required this.attendanceDay,
    @required this.typeOfService,
    @required this.inCharge,
    @required this.valuation,
    this.detail,
  });

  factory ValuationModel.fromMap(Map<String, dynamic> map) {
    return new ValuationModel(
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
      "attendanceDay": this.attendanceDay,
      "inCharge": this.inCharge,
      "typeOfService": this.typeOfService,
      "valuation": this.valuation,
      "detail": this.detail,
    };
  }
}
