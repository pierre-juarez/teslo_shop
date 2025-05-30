import 'package:formz/formz.dart';

enum NameError { empty, length, format }

class Name extends FormzInput<String, NameError> {
  const Name.pure() : super.pure('');
  const Name.dirty(super.value) : super.dirty();

  static final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.empty) return 'El campo es requerido';
    if (displayError == NameError.length) return 'Mínimo 3 caracteres';
    if (displayError == NameError.format) return 'Solo letras y espacios';

    return null;
  }

  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;
    if (value.length < 3) return NameError.length;
    if (!nameRegExp.hasMatch(value)) return NameError.format;
    return null;
  }
}
