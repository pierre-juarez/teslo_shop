import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

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
  AuthNotifier({required this.authRepository, required this.keyValueStorageService}) : super(AuthState());

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
      // on WrongCredentials {
      //   logout('Credenciales no son correctas');
      // }on ConnectionTimeout{
      //   logout('Connection timeout');
      // }
    } catch (e) {
      logout('Error no controlado');
    }
  }

  Future<void> registerUser(String email, String password, String fullName) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.register(email, password, fullName);
      logout('El usuario ${user.email} ha sido creado');
      // _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void checkAuthStatus() async {}
  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKeyValue('token');
    state = state.copyWith(authStatus: AuthStatus.unauthenticated, user: null, errorMessage: errorMessage);
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue('token', user.token);
    state = state.copyWith(user: user, authStatus: AuthStatus.authenticated, errorMessage: '');
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return AuthNotifier(authRepository: authRepository, keyValueStorageService: keyValueStorageService);
});
