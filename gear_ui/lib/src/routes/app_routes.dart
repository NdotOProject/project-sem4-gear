import 'package:gear_ui/src/routes/impl/cart_page_route.dart';
import 'package:gear_ui/src/routes/impl/home_page_route.dart';
import 'package:gear_ui/src/routes/impl/order_preview_page_route.dart';
import 'package:gear_ui/src/routes/impl/product_detail_page_route.dart';
import 'package:gear_ui/src/routes/impl/search_page_route.dart';
import 'package:gear_ui/src/routes/impl/sign_in_page_route.dart';

class AppRoutes {
  AppRoutes._();

  static final HomePageRoute _home = HomePageRoute();
  static final ProductDetailRoute _productDetail = ProductDetailRoute();
  static final SearchPageRoute _search = SearchPageRoute();
  static final SignInPageRoute _signIn = SignInPageRoute();
  static final CartPageRoute _cart = CartPageRoute();
  static final OrderPreviewPageRoute _orderPreview = OrderPreviewPageRoute();

  static HomePageRoute get home => _home;

  static ProductDetailRoute get productDetail => _productDetail;

  static SearchPageRoute get search => _search;

  static SignInPageRoute get signIn => _signIn;

  static CartPageRoute get cart => _cart;

  static OrderPreviewPageRoute get orderPreview => _orderPreview;
}
