import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/products.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      // First screen
      GoRoute(path: '/splash', builder: (context, state) => const CheckAuthStatusScreen()),

      ///* Auth Routes
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),

      ///* Product Routes
      GoRoute(path: '/', builder: (context, state) => const ProductsScreen()),
      GoRoute(path: '/product/:id', builder: (context, state) => ProductScreen(productId: state.pathParameters['id'] ?? 'no-id')),
    ],
    redirect: (context, state) {
      final isGoingTo = state.uri.path;
      final authStatus = goRouterNotifier.authStatus;

      // Mientras se está comprobando la autenticación
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) return null;

      // Si no está autenticado
      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null; // Y va a login o registro, que continue
        return '/login'; // Si va a otro lado, redirijo a login
      }

      // Si está autenticado
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash') {
          return '/'; // Y va a login o registro, que redirijo a inicio porque está autenticado
        }
      }

      return null;
    },
  );
});
