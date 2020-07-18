import 'package:aulataller/domain/entities/aulaAbiertaService.dart';
import 'package:flutter/foundation.dart' show required;

class AulaAbiertaServiceModel extends AulaAbiertaService {
  String startTime;
  String endTime;
  String link;
  String assignment;
  String theme;
  String teacher;
  String campus;
  String id;
  String day;

  AulaAbiertaServiceModel({
    @required this.startTime,
    @required this.endTime,
    @required this.teacher,
    this.link,
    this.assignment,
    this.theme,
    this.campus,
    @required this.id,
    @required this.day,
  });

  factory AulaAbiertaServiceModel.fromMap(Map<String, dynamic> map) {
    Map<int, String> _days = {
      0: "Domingo",
      1: "Lunes",
      2: "Martes",
      3: "Miércoles",
      4: "Jueves",
      5: "Viernes",
      6: "Sábado"
    };
    return new AulaAbiertaServiceModel(
      theme: map["tema"] ?? null,
      link: map["enlace"] ?? null,
      campus: map["sede"],
      assignment:
          map["idAsignatura"] != null ? map["idAsignatura"]["nombre"] : null,
      teacher: map["encargado"],
      startTime: map["horaInicio"].toString().contains('.')
          ? map["horaInicio"].toString().split('.')[0] + ":30"
          : map["horaInicio"].toString(),
      endTime: map["horaFinal"].toString().contains('.')
          ? map["horaFinal"].toString().split('.')[0] + ":30"
          : map["horaFinal"].toString(),
      id: map["_id"],
      day: _days[map["dia"]],
    );
  }

  Map<String, dynamic> toMap() => {
        "theme": this.theme,
        "link": this.link,
        "campus": this.campus,
        "assignment": this.assignment,
        "teacher": this.teacher,
        "startTime": this.startTime,
        "endTime": this.endTime,
        "id": this.id,
        "day": this.day,
      };
}
