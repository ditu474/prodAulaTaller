import 'package:formz/formz.dart';

enum DocumentValidationError { invalid }

class Document extends FormzInput<String, DocumentValidationError> {
  const Document.pure() : super.pure('');
  const Document.dirty([String value = '']) : super.dirty(value);

  @override
  DocumentValidationError validator(String value) {
    return value.length > 8 && value.length < 15
        ? null
        : DocumentValidationError.invalid;
  }
}
