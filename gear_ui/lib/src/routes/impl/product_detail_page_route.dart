import 'package:flutter/widgets.dart';

// external packages
import 'package:go_router/go_router.dart';

// internal packages
import 'package:gear_ui/src/features/product/presentation/product_detail.dart';
import 'package:gear_ui/src/routes/app_route.dart';

class ProductDetailRoute extends AppRoute {
  static const String _pathParamId = "id";

  @override
  void asDestination({
    required BuildContext context,
    int? productId,
  }) {
    context.pushNamed(
      name,
      pathParameters: <String, String>{
        _pathParamId: "$productId",
      },
    );
  }

  @override
  Widget builder(BuildContext context, GoRouterState state) {
    final String? productId = state.pathParameters[_pathParamId];
    return ProductDetail(
      productId: productId != null ? int.tryParse(productId) : null,
    );
  }

  @override
  String get name => "ProductDetailRoute";

  @override
  String get path => "products/:$_pathParamId";
}
