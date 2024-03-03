import 'package:flutter/foundation.dart';

// external packages
import 'package:get/get.dart';

// internal packages
import 'package:gear_ui/src/features/cart/data/cart_repository.dart';
import 'package:gear_ui/src/local_storage/objects/cached_cart_item.dart';

class CartPageController extends GetxController {
  final RxMap<int, CachedCartItem> _items = <int, CachedCartItem>{}.obs;
  final RxMap<int, CachedCartItem> _selected = <int, CachedCartItem>{}.obs;

  RxList<CachedCartItem> get allItems => [..._items.values].obs;

  RxList<CachedCartItem> get selectedItems => [..._selected.values].obs;

  bool get selectedAll {
    return _items.isNotEmpty && mapEquals(_items, _selected);
  }

  double get totalAmount {
    return _selected.values.fold(0.0, (previousValue, element) {
      return previousValue += (element.price ?? 0);
    });
  }

  void handleItemQuantityChange(CachedCartItem item) {
    if (item.selected) {
      _selected[item.productId] = item;
    }
  }

  void handleSelectAllItems(bool? value) {
    for (var entry in _items.entries) {
      var item = entry.value;
      item.selected = value ?? false;
      item.save();

      if (item.selected) {
        _selected[item.productId] = item;
      } else {
        _selected.remove(item.productId);
      }
    }
  }

  void handleSelectItem(CachedCartItem item) {
    if (item.selected) {
      selectedItems.add(item);
      _selected[item.productId] = item;
    } else {
      selectedItems.remove(item);
      _selected.remove(item.productId);
    }
  }

  Future<void> addItem(int productId) async {
    final repository = await CartRepository.instance();
    final item = CachedCartItem(
      productId: productId,
    );
    await repository.add(item);
    await fetchData();
  }

  Future<void> fetchData() async {
    final repository = await CartRepository.instance();
    for (var item in await repository.findAll()) {
      _items[item.productId] = item;
      if (item.selected) {
        _selected[item.productId] = item;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    fetchData();
  }
}
