import 'package:formz/formz.dart';

enum TypeOfDocumentValidationError { invalid }

class TypeOfDocument extends FormzInput<String, TypeOfDocumentValidationError> {
  const TypeOfDocument.pure() : super.pure('');
  const TypeOfDocument.dirty([String value = '']) : super.dirty(value);

  @override
  TypeOfDocumentValidationError validator(String value) {
    return value.isNotEmpty ? null : TypeOfDocumentValidationError.invalid;
  }
}
