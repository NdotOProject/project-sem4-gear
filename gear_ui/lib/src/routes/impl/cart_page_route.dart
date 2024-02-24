import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/cart/presentation/cart_page.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:go_router/go_router.dart';

class CartPageRoute extends AppRoute {
  @override
  void asDestination({required BuildContext context}) {
    context.pushNamed(name);
  }

  @override
  Widget builder(BuildContext context, GoRouterState state) {
    return CartPage();
  }

  @override
  String get name => "CartPageRoute";

  @override
  String get path => "/cart";
}
