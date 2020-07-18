import 'package:flutter/foundation.dart' show required;

class Service {
  final String _name;
  final List<String> _privacy;
  final String _id;

  Service({
    @required name,
    @required privacy,
    @required id,
  })  : this._id = id,
        this._name = name,
        this._privacy = privacy;

  String get name => this._name;
  List<String> get privacy => this._privacy;
  String get id => this._id;
}
