import 'package:flutter/widgets.dart';

// external packages
import 'package:go_router/go_router.dart';

// internal packages
import 'package:gear_ui/src/features/products/presentation/home_product_list.dart';
import 'package:gear_ui/src/routes/app_route.dart';

class HomePageRoute extends AppRoute {
  @override
  void asDestination({required BuildContext context}) {
    context.goNamed(name);
  }

  @override
  Widget builder(BuildContext context, GoRouterState state) {
    return const HomeProductList();
  }

  @override
  String get name => "HomePageRoute";

  @override
  String get path => "/";
}
