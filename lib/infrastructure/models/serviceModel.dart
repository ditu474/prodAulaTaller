import 'package:aulataller/domain/entities/service.dart';
import 'package:flutter/foundation.dart' show required;

class ServiceModel extends Service {
  final String id;
  final String name;
  final List<String> privacy;

  ServiceModel({
    @required this.id,
    @required this.name,
    @required this.privacy,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return new ServiceModel(
      id: map["_id"],
      name: map["nombre"],
      privacy: List.from(map["privacidad"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "privacy": this.privacy,
    };
  }
}
