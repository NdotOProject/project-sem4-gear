// external packages
import 'package:hive_flutter/adapters.dart';

// internal packages
import 'package:gear_ui/src/configurations/hive_config.dart';
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';

class HiveBoxes {
  static Future<Box<E>> _getBox<E>(String name) async {
    return await Hive.boxExists(name) && Hive.isBoxOpen(name)
        ? Hive.box<E>(name)
        : await Hive.openBox<E>(name);
  }

  static Future<Box> get settings async {
    return await _getBox(settingsBoxName);
  }

  static Future<Box<Product>> get products async {
    if (!Hive.isAdapterRegistered(productTypeId)) {
      Hive.registerAdapter(ProductAdapter());
    }
    return await _getBox(productsBoxName);
  }

  static Future<Box<CartProduct>> get cart async {
    if (!Hive.isAdapterRegistered(cartProductTypeId)) {
      Hive.registerAdapter(CartProductAdapter());
    }
    return await _getBox(cartBoxName);
  }

  static Future<void> startCache() async {
    await Hive.initFlutter();
  }

  static Future<void> clearCache() async {
    if (await Hive.boxExists(productsBoxName)) {
      await Hive.deleteBoxFromDisk(productsBoxName);
    }
  }

  static Future<int> clearBox<T>(Box<T> box) async {
    return await box.clear();
  }
}
