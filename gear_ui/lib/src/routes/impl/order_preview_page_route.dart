import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/order/domain/order_preview_item.dart';
import 'package:gear_ui/src/features/order/presentation/preview_page/page.dart';

// external packages
import 'package:go_router/go_router.dart';

// internal packages
import 'package:gear_ui/src/routes/app_route.dart';

class OrderPreviewPageRoute extends AppRoute {
  @override
  void asDestination({
    required BuildContext context,
    List<OrderPreviewItem>? orderItems,
  }) {
    assert(orderItems != null);
    context.pushNamed(
      name,
      extra: orderItems,
    );
  }

  @override
  Widget builder(BuildContext context, GoRouterState state) {
    return OrderPreviewPage(
      items: state.extra as List<OrderPreviewItem>,
    );
  }

  @override
  String get name => "OrderPreviewPageRoute";

  @override
  String get path => "/order/preview";
}
