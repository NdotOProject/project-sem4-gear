// external packages
import 'package:hive_flutter/adapters.dart';

// internal packages
import 'package:gear_ui/src/features/auth/domain/user.dart';
import 'package:gear_ui/src/local_storage/objects/cached_cart_item.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';
import 'package:gear_ui/src/utils/pagination_param.dart';

class CartRepository {
  final User? _user;
  final Box<CachedCartItem> _cartBox;

  const CartRepository._(this._cartBox, this._user);

  static Future<CartRepository> instance({User? user}) async {
    return CartRepository._(await CachedObjects.cart, user);
  }

  List<CachedCartItem> get _cached => [..._cartBox.values];

  bool get _isSignedIn => _user != null;

  Future<List<CachedCartItem>> findAll({PaginationParam? param}) async {
    if (_isSignedIn) {
      // TODO: call api with user id. => cache
      return [];
    } else {
      // TODO: load from cached.
      return _cached.toList();
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
    if (_isSignedIn) {
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
