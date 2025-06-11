import 'package:formz/formz.dart';

// Define input validation errors
enum SlugError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Slug extends FormzInput<String, SlugError> {
  // Call super.pure to represent an unmodified form input.
  const Slug.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Slug.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == SlugError.empty) return 'El campo es requerido';
    if (displayError == SlugError.format) return 'El slug debe tener solo caracteres alfanumericos';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SlugError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return SlugError.empty;
    if (!RegExp(r'^[a-zA-Z0-9-_]+$').hasMatch(value)) return SlugError.format;

    return null;
  }
}
