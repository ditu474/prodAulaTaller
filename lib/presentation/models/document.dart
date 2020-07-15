import 'package:formz/formz.dart';

enum DocumentValidationError { invalid }

class Document extends FormzInput<String, DocumentValidationError> {
  final String typeOfDocument;
  const Document.pure({this.typeOfDocument = ""}) : super.pure('');
  const Document.dirty({String value = '', this.typeOfDocument = ""})
      : super.dirty(value);

  static final _onlyNumber = new RegExp(
    r'^\d{8,12}$',
  );

  static final _validPassport = new RegExp(
    r'^(?!^0+$)[a-zA-Z0-9]{6,9}$',
  );

  @override
  DocumentValidationError validator(String value) {
    if (typeOfDocument == "Pasaporte" && !_validPassport.hasMatch(value)) {
      return DocumentValidationError.invalid;
    } else if (typeOfDocument != "Pasaporte" && !_onlyNumber.hasMatch(value)) {
      return DocumentValidationError.invalid;
    }
    return null;
  }
}
