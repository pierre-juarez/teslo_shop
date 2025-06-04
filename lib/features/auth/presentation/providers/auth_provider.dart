import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthState {
  AuthState({this.authStatus = AuthStatus.checking, this.user, this.errorMessage = ''});
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState copyWith({AuthStatus? authStatus, User? user, String? errorMessage}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required this.authRepository}) : super(AuthState());

  final AuthRepository authRepository;

  void loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout('Credenciales no son correctas');
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registerUser(String email, String password) async {}
  void checkAuthStatus() async {}
  Future<void> logout([String? errorMessage]) async {
    // TODO: Limpiar token
    state = state.copyWith(authStatus: AuthStatus.unauthenticated, user: null, errorMessage: errorMessage);
  }

  void _setLoggedUser(User user) {
    // TODO: Guardar token físicamente
    state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(authRepository: authRepository);
});
