// external packages
import 'package:go_router/go_router.dart';

// internal packages
import 'package:gear_ui/src/routes/app_routes.dart';

class AppRouter {
  static GoRouter get config {
    return GoRouter(
      initialLocation: AppRoutes.home.path,
      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.home.path,
          name: AppRoutes.home.name,
          builder: AppRoutes.home.builder,
          routes: [
            GoRoute(
              path: AppRoutes.productDetail.path,
              name: AppRoutes.productDetail.name,
              builder: AppRoutes.productDetail.builder,
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.signIn.path,
          name: AppRoutes.signIn.name,
          builder: AppRoutes.signIn.builder,
        ),
        GoRoute(
          path: AppRoutes.search.path,
          name: AppRoutes.search.name,
          builder: AppRoutes.search.builder,
        ),
        GoRoute(
          path: AppRoutes.cart.path,
          name: AppRoutes.cart.name,
          builder: AppRoutes.cart.builder,
        ),
        GoRoute(
          path: AppRoutes.orderPreview.path,
          name: AppRoutes.orderPreview.name,
          builder: AppRoutes.orderPreview.builder,
        ),
      ],
    );
  }
}
