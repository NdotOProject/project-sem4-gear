import 'package:gear_ui/src/routes/app_route.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _goRouter = GoRouter(
    initialLocation: AppRoutes.home.path,
    routes: AppRoutes.routes,
  );

  GoRouter get config => _goRouter;
}
