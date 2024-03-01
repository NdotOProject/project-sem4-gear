// external packages
import 'package:gear_ui/src/local_storage/objects/cached_cart_item.dart';
import 'package:gear_ui/src/local_storage/objects/cached_product_color.dart';
import 'package:gear_ui/src/local_storage/objects/cached_product_size.dart';
import 'package:hive_flutter/adapters.dart';

// internal packages
import 'package:gear_ui/src/local_storage/objects/cached_product.dart';

class CachedObjects {
  const CachedObjects._();

  // box names
  static const String cartBoxName = "cart";
  static const String productsBoxName = "products";
  static const String productColorsBoxName = "productColors";
  static const String productSizesBoxName = "productSizes";

  static Future<void> startCache() async {
    await Hive.initFlutter();
  }

  static Future<void> clearCache() async {
    if (await Hive.boxExists(productsBoxName)) {
      await Hive.deleteBoxFromDisk(productsBoxName);
    }
  }

  static Future<Box<E>> _getBox<E>(String name) async {
    return await Hive.boxExists(name) && Hive.isBoxOpen(name)
        ? Hive.box<E>(name)
        : await Hive.openBox<E>(name);
  }

  static Future<Box<CachedCartItem>> get cart async {
    if (!Hive.isAdapterRegistered(CachedCartItem.typeId)) {
      Hive.registerAdapter(CachedCartItemAdapter());
    }
    return await _getBox(cartBoxName);
  }

  static Future<Box<CachedProduct>> get products async {
    if (!Hive.isAdapterRegistered(CachedProduct.typeId)) {
      Hive.registerAdapter(CachedProductAdapter());
    }
    return await _getBox(productsBoxName);
  }

  static Future<Box<CachedProductColor>> get productColors async {
    if (!Hive.isAdapterRegistered(CachedProductColor.typeId)) {
      Hive.registerAdapter(CachedProductColorAdapter());
    }
    return await _getBox(productColorsBoxName);
  }

  static Future<Box<CachedProductSize>> get productSizes async {
    if (!Hive.isAdapterRegistered(CachedProductSize.typeId)) {
      Hive.registerAdapter(CachedProductSizeAdapter());
    }
    return await _getBox(productSizesBoxName);
  }
}
