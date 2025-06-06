import 'package:flutter/foundation.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

class GoRouterNotifier extends ChangeNotifier {
  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }
}
