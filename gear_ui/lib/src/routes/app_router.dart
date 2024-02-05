import 'package:flutter/widgets.dart';

// external packages
import 'package:go_router/go_router.dart';

// internal packages
import 'package:gear_ui/src/features/auth/presentation/sign_in.dart';
import 'package:gear_ui/src/features/products/presentation/product_detail.dart';
import 'package:gear_ui/src/features/products/presentation/product_list.dart';
import 'package:gear_ui/src/features/searches/presentation/search_page.dart';

class AppRouter {
  static GoRouter get config {
    return GoRouter(
      initialLocation: AppRoutes.home._path,
      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.home._path,
          name: AppRoutes.home.name,
          builder: (context, state) {
            return const ProductList();
          },
          routes: [
            GoRoute(
              path: AppRoutes.productDetail._path,
              name: AppRoutes.productDetail.name,
              builder: (context, state) {
                final productId = state.pathParameters["id"];
                return ProductDetail(
                  productId: int.tryParse(productId!),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.signIn._path,
          name: AppRoutes.signIn.name,
          builder: (context, state) {
            return const SignIn();
          },
        ),
        GoRoute(
          path: AppRoutes.search._path,
          name: AppRoutes.search.name,
          builder: (context, state) {
            return const SearchPage();
          },
        ),
      ],
    );
  }

  static final Map<AppRoutes, _GoRouterMethod Function(BuildContext context)>
      _redirectCases = {
    AppRoutes.home: (context) => context.goNamed,
    AppRoutes.search: (context) => context.pushNamed,
    AppRoutes.productDetail: (context) => context.pushNamed,
    AppRoutes.signIn: (context) => context.pushNamed,
  };

  static void redirectTo({
    required AppRoutes route,
    required BuildContext context,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    _redirectCases[route]!(context)(
      route.name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
}

typedef _GoRouterMethod = void Function(
  String name, {
  Map<String, String> pathParameters,
  Map<String, dynamic> queryParameters,
  Object? extra,
});

enum AppRoutes {
  home(
    path: "/",
  ),
  signIn(
    path: "/sign-in",
  ),
  productDetail(
    path: "products/:id",
  ),
  search(
    path: "/search",
  ),
  ;

  final String _path;

  const AppRoutes({
    required String path,
  }) : _path = path;
}
