import 'package:flutter/foundation.dart' show required;

class AulaAbiertaService {
  final String _startTime;
  final String _endTime;
  final String _link;
  final String _assignment;
  final String _theme;
  final String _teacher;
  final String _campus;
  final String _id;
  final String _day;

  AulaAbiertaService({
    @required startTime,
    @required endTime,
    @required teacher,
    link,
    assignment,
    theme,
    campus,
    @required id,
    @required day,
  })  : this._assignment = assignment,
        this._campus = campus,
        this._id = id,
        this._link = link,
        this._endTime = endTime,
        this._startTime = startTime,
        this._teacher = teacher,
        this._theme = theme,
        this._day = day;

  String get startTime => this._startTime;
  String get endTime => this._endTime;
  String get assignment => this._assignment;
  String get campus => this._campus;
  String get id => this._id;
  String get link => this._link;
  String get teacher => this._teacher;
  String get theme => this._theme;
  String get day => this._day;
}
