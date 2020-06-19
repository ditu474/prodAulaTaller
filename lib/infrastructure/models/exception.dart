class CustomException implements Exception{
  final _message;

  CustomException(this._message);

  @override
  String toString() {
    return "${this._message}";
  }
}