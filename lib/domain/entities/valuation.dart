import 'package:flutter/foundation.dart' show required;

class Valuation {
  final String _attendanceDay;
  final String _typeOfService;
  final String _inCharge;
  final int _valuation;
  final String _detail;

  Valuation({
    @required attendanceDay,
    @required typeOfService,
    @required inCharge,
    @required valuation,
    detail,
  })  : this._attendanceDay = attendanceDay,
        this._typeOfService = typeOfService,
        this._inCharge = inCharge,
        this._valuation = valuation,
        this._detail = detail;

  String get attendanceDay => this._attendanceDay;
  String get typeOfService => this._typeOfService;
  String get inCharge => this._inCharge;
  int get valuation => this._valuation;
  String get detail => this._detail;
}
