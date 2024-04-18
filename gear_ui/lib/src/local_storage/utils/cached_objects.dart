// external packages
import 'package:hive_flutter/adapters.dart';

// internal packages
import 'package:gear_ui/src/local_storage/obj/cached_cart_item.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_brand.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_feedback.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_product.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_product_color.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_product_detail.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_product_size.dart';
import 'package:gear_ui/src/local_storage/obj/users/cached_user.dart';

class CachedObjects {
  const CachedObjects._();

  // box names
  // orders
  static const String cartBoxName = "cart";

  static Future<void> startCache() async {
    await Hive.initFlutter();
  }

  // static Future<void> clearCache() async {
  //   if (await Hive.boxExists(productsBoxName)) {
  //     await Hive.deleteBoxFromDisk(productsBoxName);
  //   }
  // }

  static Future<Box<E>> _getBox<E>(String name) async {
    return await Hive.boxExists(name) && Hive.isBoxOpen(name)
        ? Hive.box<E>(name)
        : await Hive.openBox<E>(name);
  }

  // orders
  static Future<Box<CachedCartItem>> get cart async {
    if (!Hive.isAdapterRegistered(CachedCartItem.typeId)) {
      Hive.registerAdapter(CachedCartItemAdapter());
    }
    return await _getBox(cartBoxName);
  }

  // products
  static Future<Box<CachedBrand>> get brands async {
    if (!Hive.isAdapterRegistered(CachedBrand.typeId)) {
      Hive.registerAdapter(CachedBrandAdapter());
    }
    return await _getBox<CachedBrand>(CachedBrand.boxName);
  }

  static Future<Box<CachedFeedback>> get feedbacks async {
    if (!Hive.isAdapterRegistered(CachedFeedback.typeId)) {
      Hive.registerAdapter(CachedFeedbackAdapter());
    }
    return await _getBox<CachedFeedback>(CachedFeedback.boxName);
  }

  static Future<Box<CachedProduct>> get products async {
    if (!Hive.isAdapterRegistered(CachedProduct.typeId)) {
      Hive.registerAdapter(CachedProductAdapter());
    }
    return await _getBox<CachedProduct>(CachedProduct.boxName);
  }

  static Future<Box<CachedProductDetail>> get productDetails async {
    if (!Hive.isAdapterRegistered(CachedProductDetail.typeId)) {
      Hive.registerAdapter(CachedProductDetailAdapter());
    }
    return await _getBox<CachedProductDetail>(CachedProductDetail.boxName);
  }

  static Future<Box<CachedProductColor>> get productColors async {
    if (!Hive.isAdapterRegistered(CachedProductColor.typeId)) {
      Hive.registerAdapter(CachedProductColorAdapter());
    }
    return await _getBox<CachedProductColor>(CachedProductColor.boxName);
  }

  static Future<Box<CachedProductSize>> get productSizes async {
    if (!Hive.isAdapterRegistered(CachedProductSize.typeId)) {
      Hive.registerAdapter(CachedProductSizeAdapter());
    }
    return await _getBox<CachedProductSize>(CachedProductSize.boxName);
  }

  static Future<Box<CachedUser>> get user async {
    if (!Hive.isAdapterRegistered(CachedUser.typeId)) {
      Hive.registerAdapter(CachedUserAdapter());
    }
    return await _getBox<CachedUser>(CachedUser.boxName);
  }
}
