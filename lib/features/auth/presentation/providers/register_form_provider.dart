import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/confirm_password.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

class RegisterFormState {
  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
  });

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Name name;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  // copyWith
  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
  }) {
    return RegisterFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  String toString() {
    return '''
      RegisterFormState:
        isPosting: $isPosting, 
        isFormPosted: $isFormPosted, 
        isValid: $isValid, 
        name: $name, 
        email: $email, 
        password: $password, 
        confirmPassword: $confirmPassword}
    ''';
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  void onNameChange(String value) {
    final newName = Name.dirty(value);
    state = state.copyWith(name: newName, isValid: Formz.validate([newName, state.email, state.password, state.confirmPassword]));
  }

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.name, state.password, state.confirmPassword]),
    );
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.name, state.email, state.confirmPassword]),
    );
  }

  void onConfirmPasswordChange(String value) {
    final newConfirmPassword = ConfirmPassword.dirty(password: state.password.value, value: value);
    state = state.copyWith(
      confirmPassword: newConfirmPassword,
      isValid: Formz.validate([newConfirmPassword, state.name, state.email, state.password]),
    );
  }

  void onFormSubmit() {
    _touchEveryField();
    print(state);
    if (!state.isValid) return;
  }

  void _touchEveryField() {
    final name = Name.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(password: state.password.value, value: state.confirmPassword.value);
    state = state.copyWith(
      isFormPosted: true,
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([name, email, password, confirmPassword]),
    );
  }
}

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
  (ref) => RegisterFormNotifier(),
);
