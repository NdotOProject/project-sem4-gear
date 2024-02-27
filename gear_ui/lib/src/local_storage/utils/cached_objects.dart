// external packages
import 'package:hive_flutter/adapters.dart';

// internal packages
import 'package:gear_ui/src/local_storage/objects/cached_product.dart';

class CachedObjects {
  const CachedObjects._();

  // box names
  static const String productsBoxName = "products";

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

  static Future<Box<CachedProduct>> get products async {
    if (!Hive.isAdapterRegistered(CachedProduct.typeId)) {
      Hive.registerAdapter(CachedProductAdapter());
    }
    return await _getBox(productsBoxName);
  }
}
