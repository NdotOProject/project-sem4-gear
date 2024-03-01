import 'package:flutter/material.dart';

// external packages
import 'package:get/get.dart';

// internal packages
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/features/product/data/product_repository.dart';
import 'package:gear_ui/src/features/product_size/data/product_size_repository.dart';
import 'package:gear_ui/src/local_storage/objects/cached_cart_item.dart';
import 'package:gear_ui/src/local_storage/objects/cached_product_size.dart';

class CartItemController extends GetxController {
  final Rx<CachedCartItem> item;
  final ValueChanged<CachedCartItem> onSelected;

  CartItemController({
    required this.item,
    required this.onSelected,
  });

  RxInt quantity = 0.obs;
  Rx<CartProduct>? product;
  RxList<CachedProductSize> sizes = <CachedProductSize>[].obs;
  Rx<CachedProductSize>? selectedSize;

  final _errorSize = CachedProductSize(id: 0, name: "", productIds: []);
  final _errorProduct = CartProduct(id: 0, name: '', price: 0, quantity: 0);

  void handleSelected(bool? _) {
    item.value.selected = !item.value.selected;
    item.value.save();
    onSelected(item.value);
  }

  void handleSelectSize(CachedProductSize? size) {
    selectedSize = (size ?? _errorSize).obs;
    item.value.sizeId = selectedSize?.value.id;
    item.value.save();
  }

  void _loadRequireData() async {
    final productRepository = await ProductRepository.instance;
    final cachedProduct =
        await productRepository.findById(item.value.productId);

    product = cachedProduct != null
        ? CartProduct.fromCached(cachedProduct).obs
        : _errorProduct.obs;

    final sizeRepository = await ProductSizeRepository.instance;
    if (product != null) {
      sizes = (await sizeRepository.findAllByProductId(product!.value.id)).obs;
    }

    if (item.value.sizeId != null) {
      final cachedSize = await sizeRepository.findById(item.value.sizeId!);
      selectedSize = (cachedSize ?? _errorSize).obs;
    } else if (sizes.isNotEmpty) {
      handleSelectSize(sizes[0]);
    }
  }

  @override
  void onInit() {
    super.onInit();

    quantity = item.value.quantity.obs;

    _loadRequireData();
  }
}
