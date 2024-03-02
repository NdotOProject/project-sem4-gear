import 'package:flutter/material.dart';

// external packages
import 'package:get/get.dart';

// internal packages
import 'package:gear_ui/src/features/cart/data/cart_repository.dart';
import 'package:gear_ui/src/features/order/domain/order_preview_item.dart';
import 'package:gear_ui/src/local_storage/objects/cached_cart_item.dart';
import 'package:gear_ui/src/routes/app_routes.dart';

class CartPageController extends GetxController {
  Future<CartRepository> get _cartRepository {
    return CartRepository.instance();
  }

  RxList<CachedCartItem> cartItems = <CachedCartItem>[].obs;

  RxList<CachedCartItem> selectedItems = <CachedCartItem>[].obs;

  bool get isSelectAll {
    return cartItems.isNotEmpty && cartItems.length == selectedItems.length;
  }

  void selectAllItems(bool? value) {
    selectedItems.clear();
    for (var item in cartItems) {
      item.selected = value ?? false;
      item.save();
    }

    selectedItems = [...cartItems.where((item) => item.selected)].obs;
  }

  void selectItem(CachedCartItem item) {
    if (item.selected) {
      selectedItems.add(item);
    } else {
      selectedItems.remove(item);
    }
  }

  void redirectToOrderReviewPage(BuildContext context) {
    if (selectedItems.isNotEmpty) {
      AppRoutes.orderPreview.asDestination(
        context: context,
        orderItems: [
          ...selectedItems.map((cartItem) {
            return OrderPreviewItem(
              productId: cartItem.productId,
              colorId: cartItem.colorId ?? 0,
              sizeId: cartItem.sizeId ?? 0,
              quantity: cartItem.quantity,
              price: cartItem.price ?? 0,
            );
          })
        ],
      );
    }
  }

  Future<void> add(int productId) async {
    final repository = await _cartRepository;
    final item = CachedCartItem(
      productId: productId,
    );
    await repository.add(item);
    await fetchData();
  }

  Future<void> fetchData() async {
    final repository = await _cartRepository;
    cartItems = (await repository.findAll()).obs;
    selectedItems = [...cartItems.where((item) => item.selected)].obs;
  }

  @override
  void onInit() {
    super.onInit();

    fetchData();
  }
}
