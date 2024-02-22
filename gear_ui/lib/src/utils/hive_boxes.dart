// external packages
import 'package:hive/hive.dart';

// internal packages
import 'package:gear_ui/src/configurations/hive_config.dart';
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

  static Future<void> closeApp() async {
    if (await Hive.boxExists(productsBoxName)) {
      await Hive.deleteBoxFromDisk(productsBoxName);
    }
  }

  static Future<int> clearBox<T>(Box<T> box) async {
    return await box.clear();
  }
}
