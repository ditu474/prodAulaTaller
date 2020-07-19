import 'package:flutter/foundation.dart' show required;

class Assist {
  final bool _valued;
  final String _date;
  final String _typeOfService;
  final String _inCharge;
  final String _id;

  Assist({
    @required valued,
    @required date,
    @required typeOfService,
    @required inCharge,
    @required id,
  })  : this._valued = valued,
        this._date = date,
        this._typeOfService = typeOfService,
        this._inCharge = inCharge,
        this._id = id;

  bool get value => this._valued;
  String get date => this._date;
  String get typeOfService => this._typeOfService;
  String get inCharge => this._inCharge;
  String get id => this._id;
}
