import 'package:formz/formz.dart';

enum ConfirmPasswordError { empty, mismatch, length, format }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordError> {
  // Constructor "puro" inicial
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  // Constructor con valor "dirty"
  const ConfirmPassword.dirty({required this.password, String value = ''}) : super.dirty(value);
  final String password;

  static final RegExp passwordRegExp = RegExp(r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');

  @override
  ConfirmPasswordError? validator(String value) {
    if (value.isEmpty) return ConfirmPasswordError.empty;
    if (value.length < 6) return ConfirmPasswordError.length;
    if (!passwordRegExp.hasMatch(value)) return ConfirmPasswordError.format;
    if (value != password) return ConfirmPasswordError.mismatch;
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ConfirmPasswordError.empty) return 'El campo es requerido';
    if (displayError == ConfirmPasswordError.length) return 'Mínimo 6 caracteres';
    if (displayError == ConfirmPasswordError.format) return 'Debe de tener Mayúscula, letras y un número';
    if (displayError == ConfirmPasswordError.mismatch) return 'Las contraseñas no coinciden';

    return null;
  }
}
