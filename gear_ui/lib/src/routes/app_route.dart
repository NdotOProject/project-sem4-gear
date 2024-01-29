import 'package:gear_ui/src/features/auth/presentation/sign_in.dart';
import 'package:gear_ui/src/features/products/presentation/product_detail.dart';
import 'package:gear_ui/src/features/products/presentation/product_list.dart';
import 'package:gear_ui/src/features/searchs/presentation/search_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  home(
    name: "home",
    path: "/",
  ),
  signIn(
    name: "signIn",
    path: "/sign-in",
  ),
  productDetail(
    name: "productDetail",
    path: "products/:id",
  ),
  search(
    name: "searchPage",
    path: "/search",
  ),
  ;

  final String name;
  final String path;

  const AppRoutes({
    required this.name,
    required this.path,
  });

  static List<GoRoute> get routes {
    return <GoRoute>[
      GoRoute(
          path: home.path,
          name: home.name,
          builder: (context, state) {
            return const ProductList();
          },
          routes: [
            GoRoute(
                path: productDetail.path,
                name: productDetail.name,
                builder: (context, state) {
                  final productId = state.pathParameters["id"];
                  return ProductDetail(
                    productId: int.tryParse(productId!),
                  );
                }),
          ]),
      GoRoute(
        path: signIn.path,
        name: signIn.name,
        builder: (context, state) {
          return const SignIn();
        },
      ),
      GoRoute(
        path: search.path,
        name: search.name,
        builder: (context, state) {
          return SearchPage();
        }
      ),
    ];
  }
}
