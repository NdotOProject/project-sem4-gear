// external packages
import 'package:gear_ui/src/features/auth/data/auth_repository.dart';
import 'package:hive_flutter/adapters.dart';

// internal packages
import 'package:gear_ui/src/local_storage/obj/cached_cart_item.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';
import 'package:gear_ui/src/utils/pagination_param.dart';

class CartRepository {
  const CartRepository._(this._cartBox);

  static Future<CartRepository> get instance async {
    return CartRepository._(await CachedObjects.cart);
  }

  final Box<CachedCartItem> _cartBox;

  List<CachedCartItem> get _cached => [..._cartBox.values];

  Future<List<CachedCartItem>> findAll({PaginationParam? param}) async {
    final authRepository = await AuthRepository.instance;

    if (authRepository.isSignedIn) {



      return [];
    } else {
      if (param != null) {
        return [..._cached.getRange(param.offset, param.nextOffset)];
      }

      return _cached;
    }
  }

  Future<CachedCartItem?> findByProductId(int productId) async {
    return _cached
        .where(
          (element) => element.productId == productId,
        )
        .take(1)
        .singleOrNull;
  }

  Future<void> add(CachedCartItem item) async {
    final authRepository = await AuthRepository.instance;

    if (authRepository.isSignedIn) {
      // TODO: call api. => cache
    } else {
      final cachedItem = await findByProductId(item.productId);
      if (cachedItem != null) {
        cachedItem.quantity++;
        cachedItem.save();
      } else {
        _cartBox.add(item);
      }
    }
  }

  Future<bool> contains(CachedCartItem item) async {
    final cachedItem = await findByProductId(item.productId);

    if (cachedItem == null) {
      return false;
    }

    return cachedItem.quantity == item.quantity;
  }
}
