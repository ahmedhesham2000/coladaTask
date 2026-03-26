import 'package:go_router/go_router.dart';

import '../../features/menu/presentation/screens/cart_page.dart';
import '../../features/menu/presentation/screens/menu_page.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => const MenuPage()),
      GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
    ],
  );
}
